#!/usr/bin/env bash
# Usage: rearch/run_dashcn_agent.sh <provider/model[#variant]> <brief-file> <log-name>
#   e.g. opencode/muse-spark-1.3-contributor-free#xhigh  or  opencode-go/muse-spark-1.3-contributor#xhigh
# Prepends the dashcn preamble ({{ROOT}} = parent of this worktree), runs OpenCode, appends `exit=<code>`.
# Launch detached:  perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_dashcn_agent.sh <model> <brief> <log> &
# Resume:           rearch/continue_agent.sh <session> <model> <prompt-file> <log>
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
PROMPT="$(sed "s#{{ROOT}}#$ROOT#g" rearch/briefs/dashcn/_common.md; echo; echo '---'; echo; cat "$2")"
opencode run "${STANDALONE[@]}" --auto --title "dashcn:$3" -m "$MODEL" "${VARIANT[@]}" "$PROMPT" > "rearch/logs/$3.log" 2>&1
echo "exit=$?" >> "rearch/logs/$3.log"
