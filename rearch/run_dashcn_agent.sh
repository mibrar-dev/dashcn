#!/usr/bin/env bash
# Usage: rearch/run_dashcn_agent.sh <model#variant> <brief-file> <log-name>
# Same as run_agent.sh but prepends the dashcn preamble (worktree paths + decisions).
# Launch detached:  perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_dashcn_agent.sh <model> <brief> <log> &
# Resume:           rearch/continue_agent.sh <session> <model> <prompt-file> <log>
# Registers itself in rearch/logs/.agents/<log-name> (pid, model, start) for rearch/watch_dashcn_agents.sh.
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$KIT"
mkdir -p rearch/logs/.agents
printf 'pid=%s\nmodel=%s\nbrief=%s\nstart=%s\n' "$$" "$1" "$2" "$(date +%s)" > "rearch/logs/.agents/$3"
PROMPT="$(cat rearch/briefs/dashcn/_common.md; echo; echo '---'; echo; cat "$2")"
opencode run --standalone --auto --title "dashcn:$3" -m "$1" "$PROMPT" > "rearch/logs/$3.log" 2>&1
echo "exit=$?" >> "rearch/logs/$3.log"
