#!/usr/bin/env bash
# Usage: rearch/resume_dashcn_agent.sh <session-id> <provider/model[#variant]> <prompt-file> <log-name> <report-path>
# Resumes an OpenCode session with <prompt-file>, then auto-continues until <report-path> says
# `status: done` or `status: blocked` (max MAX_CONTINUES). Registers for the watchdog; ends with __AGENT_EXIT__.
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$KIT"
[ -d /opt/flutter/bin ] && export PATH="/opt/flutter/bin:$PATH"
mkdir -p rearch/logs/.agents
printf 'pid=%s\nmodel=%s\nbrief=resume:%s\nstart=%s\n' "$$" "$2" "$3" "$(date +%s)" > "rearch/logs/.agents/$4"
MODEL="${2%%#*}"
VARIANT=()
[[ "$2" == *"#"* ]] && VARIANT=(--variant "${2#*#}")
LOG="rearch/logs/$4.log"
REPORT="$5"
finished() { grep -qE '^status: (done|blocked)' "$REPORT" 2>/dev/null; }
opencode run --auto -s "$1" -m "$MODEL" "${VARIANT[@]}" "$(cat "$3")" > "$LOG" 2>&1
code=$?
n=0
while [ "$code" -eq 0 ] && ! finished && [ "$n" -lt "${MAX_CONTINUES:-10}" ]; do
  n=$((n + 1))
  echo "--- auto-continue $n (report not final yet: $REPORT) ---" >> "$LOG"
  opencode run --auto -s "$1" -m "$MODEL" "${VARIANT[@]}" \
    "Continue from where you stopped. Do not stop to narrate: keep calling tools until every step and gate is done and $REPORT has a final ## RESULT block with status: done (or blocked, with the reason)." >> "$LOG" 2>&1
  code=$?
done
finished || echo "--- report not final after $n continues ---" >> "$LOG"
echo "__AGENT_EXIT__=$code" >> "$LOG"
