#!/usr/bin/env bash
# Usage: rearch/run_dashcn_agent.sh <model#variant> <brief-file> <log-name>
# Same as run_agent.sh but prepends the dashcn preamble (worktree paths + decisions).
# Launch detached:  perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_dashcn_agent.sh <model> <brief> <log> &
# Resume:           rearch/continue_agent.sh <session> <model> <prompt-file> <log>
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$KIT"
mkdir -p rearch/logs
PROMPT="$(cat rearch/briefs/dashcn/_common.md; echo; echo '---'; echo; cat "$2")"
opencode run --standalone --auto --title "dashcn:$3" -m "$1" "$PROMPT" > "rearch/logs/$3.log" 2>&1
echo "exit=$?" >> "rearch/logs/$3.log"
