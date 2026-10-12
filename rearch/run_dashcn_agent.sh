#!/usr/bin/env bash
# Usage: rearch/run_dashcn_agent.sh <provider/model[#variant]> <brief-file> <log-name>
#   e.g. opencode-go/muse-spark-1.3-contributor#xhigh  or  opencode/muse-spark-1.3-contributor-free#xhigh
# Prepends the dashcn preamble ({{ROOT}} = parent of this worktree), runs OpenCode, appends `exit=<code>`.
# `opencode run` ends whenever the model replies without a tool call (e.g. narrating its next step), so this
# auto-continues the same session until the brief's report (first `rearch/reports/*.md` or `qa_reports/*.md`
# path in the brief) contains `## RESULT`, up to MAX_CONTINUES times.
# Launch detached:  perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_dashcn_agent.sh <model> <brief> <log> &
# Resume by hand:   rearch/continue_agent.sh <session> <model> <prompt-file> <log>
# Registers itself in rearch/logs/.agents/<log-name> (pid, model, start) for rearch/watch_dashcn_agents.sh.
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(dirname "$KIT")"
cd "$KIT"
[ -d /opt/flutter/bin ] && export PATH="/opt/flutter/bin:$PATH"
mkdir -p rearch/logs/.agents
printf 'pid=%s\nmodel=%s\nbrief=%s\nstart=%s\n' "$$" "$1" "$2" "$(date +%s)" > "rearch/logs/.agents/$3"
MODEL="${1%%#*}"
VARIANT=()
[[ "$1" == *"#"* ]] && VARIANT=(--variant "${1#*#}")
STANDALONE=()
opencode run --help 2>&1 | grep -q -- '--standalone' && STANDALONE=(--standalone)
MAX_CONTINUES="${MAX_CONTINUES:-8}"
LOG="rearch/logs/$3.log"
# Report path named in the brief; $KIT/$CLI/$ROOT placeholders resolved.
REPORT="$(grep -oE '\$(KIT|CLI)/[A-Za-z0-9_./-]*(reports|qa_reports)/[A-Za-z0-9_.-]+\.md' "$2" | tail -1 \
  | sed -e "s#\$KIT#$KIT#" -e "s#\$CLI#$ROOT/dashcn-cli#")"
done_report() { [ -n "$REPORT" ] && grep -q '^## RESULT' "$REPORT" 2>/dev/null; }

PROMPT="$(sed "s#{{ROOT}}#$ROOT#g" rearch/briefs/dashcn/_common.md; echo; echo '---'; echo; cat "$2")"
opencode run "${STANDALONE[@]}" --auto --title "dashcn:$3" -m "$MODEL" "${VARIANT[@]}" "$PROMPT" > "$LOG" 2>&1
code=$?
SESSION="$(opencode session list 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | awk -v t="dashcn:$3" '$0 ~ t {print $1; exit}')"
n=0
while [ "$code" -eq 0 ] && ! done_report && [ -n "$SESSION" ] && [ "$n" -lt "$MAX_CONTINUES" ]; do
  n=$((n + 1))
  echo "--- auto-continue $n/$MAX_CONTINUES (report not written yet: ${REPORT:-unknown}) ---" >> "$LOG"
  opencode run "${STANDALONE[@]}" --auto -s "$SESSION" -m "$MODEL" "${VARIANT[@]}" \
    "Continue the task from where you stopped. Do not stop to narrate: keep calling tools until every step and gate in the brief is done and the report with the ## RESULT block is written to ${REPORT:-the report path in the brief}." >> "$LOG" 2>&1
  code=$?
done
done_report || echo "--- report missing after $n continues ---" >> "$LOG"
echo "exit=$code" >> "$LOG"
