#!/usr/bin/env bash
# Watchdog for OpenCode agents started by run_dashcn_agent.sh.
# Usage: rearch/watch_dashcn_agents.sh [interval-seconds=60]
# Prints ONE line per new event (meant for a Monitor):
#   EVENT <kind> <agent> <detail>
# kinds: DONE (launcher's __AGENT_EXIT__= line written; agents' own `exit=` echoes are ignored), MODEL_ERROR (provider/model failure in the log tail),
#        STALL (log unchanged for STALL_MIN), LONG (running > LONG_MIN, repeats every LONG_MIN),
#        DIED (process gone, no exit= line), HEARTBEAT (every HEARTBEAT_MIN, lists running agents).
# Agents finished/dead are moved to rearch/logs/.agents/done/ so each fires once.
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
REG="$KIT/rearch/logs/.agents"
INTERVAL="${1:-60}"
STALL_MIN="${STALL_MIN:-25}"
LONG_MIN="${LONG_MIN:-90}"
HEARTBEAT_MIN="${HEARTBEAT_MIN:-30}"
ERR_RE='Insufficient account funds|Model unavailable|Endpoint is unavailable|not issued to this caller|rate limit|429 Too Many|ECONNRESET|context length|maximum context'
mkdir -p "$REG/done"
last_beat=$(date +%s)

mtime() {  # GNU first (BSD stat lacks -c); BSD -f %m on macOS
  local t; t=$(stat -c %Y "$1" 2>/dev/null) || t=$(stat -f %m "$1" 2>/dev/null) || t=0
  case "$t" in ''|*[!0-9]*) t=0 ;; esac; echo "$t"
}

while true; do
  now=$(date +%s)
  running=""
  for f in "$REG"/*; do
    [ -f "$f" ] || continue
    name="$(basename "$f")"
    pid="$(sed -n 's/^pid=//p' "$f")"
    start="$(sed -n 's/^start=//p' "$f")"
    model="$(sed -n 's/^model=//p' "$f")"
    log="$KIT/rearch/logs/$name.log"
    state="$KIT/rearch/logs/.agents/.$name.state"
    touch "$state"
    if [ -f "$log" ] && grep -q '^__AGENT_EXIT__=' "$log"; then
      echo "EVENT DONE $name $(grep '^__AGENT_EXIT__=' "$log" | tail -1) model=$model mins=$(( (now - start) / 60 ))"
      mv "$f" "$REG/done/$name"; rm -f "$state"; continue
    fi
    if ! kill -0 "$pid" 2>/dev/null; then
      echo "EVENT DIED $name pid=$pid model=$model (no __AGENT_EXIT__ line)"
      mv "$f" "$REG/done/$name"; rm -f "$state"; continue
    fi
    running="$running $name"
    # Model/provider errors: only look at lines added since the last check (agents echo old text).
    size=$(wc -c < "$log" 2>/dev/null || echo 0)
    seen=$(sed -n 's/^size=//p' "$state"); seen=${seen:-0}
    if [ "$size" -gt "$seen" ]; then
      hit=$(tail -c +$((seen + 1)) "$log" | grep -Eo "$ERR_RE" | head -1)
      [ -n "$hit" ] && echo "EVENT MODEL_ERROR $name \"$hit\" model=$model"
    fi
    age=$(( (now - $(mtime "$log")) / 60 ))
    stalled=$(sed -n 's/^stalled=//p' "$state")
    if [ "$age" -ge "$STALL_MIN" ] && [ "$stalled" != 1 ]; then
      echo "EVENT STALL $name no log output for ${age}m model=$model"; stalled=1
    elif [ "$age" -lt "$STALL_MIN" ]; then stalled=0; fi
    run=$(( (now - start) / 60 ))
    longn=$(sed -n 's/^long=//p' "$state"); longn=${longn:-0}
    if [ "$run" -ge $(( LONG_MIN * (longn + 1) )) ]; then
      echo "EVENT LONG $name running ${run}m model=$model"; longn=$((longn + 1))
    fi
    printf 'size=%s\nstalled=%s\nlong=%s\n' "$size" "${stalled:-0}" "$longn" > "$state"
  done
  if [ $(( now - last_beat )) -ge $(( HEARTBEAT_MIN * 60 )) ]; then
    echo "EVENT HEARTBEAT - running=[${running:- none}]"; last_beat=$now
  fi
  sleep "$INTERVAL"
done
