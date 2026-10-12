#!/usr/bin/env bash
# Usage: rearch/continue_agent.sh <session-id> <provider/model[#variant]> <prompt-file> <log-name>
set -u
KIT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$KIT"
[ -d /opt/flutter/bin ] && export PATH="/opt/flutter/bin:$PATH"
MODEL="${2%%#*}"
VARIANT=()
[[ "$2" == *"#"* ]] && VARIANT=(--variant "${2#*#}")
STANDALONE=()
opencode run --help 2>&1 | grep -q -- '--standalone' && STANDALONE=(--standalone)
opencode run "${STANDALONE[@]}" --auto -s "$1" -m "$MODEL" "${VARIANT[@]}" "$(cat "$3")" > "rearch/logs/$4.log" 2>&1
echo "exit=$?" >> "rearch/logs/$4.log"
