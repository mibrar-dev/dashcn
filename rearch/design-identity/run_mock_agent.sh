#!/usr/bin/env bash
# Usage: run_mock_agent.sh <model#variant> <A|B|C|D>
set -u
KIT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$KIT"
D="$2"; OUT="rearch/design-identity/mockups/$D"
mkdir -p "$OUT"
PROMPT="$(cat rearch/design-identity/briefs/full_$D.md)

OUTPUT LOCATION (strict): write ONLY these files: $OUT/index.html, $OUT/home.html, $OUT/theming.html,
$OUT/component.html (optionally one shared $OUT/tokens.css and $OUT/app.js). Do not touch any other file in the
repo, do not run git, do not run flutter. Each HTML file must open directly from disk (file://) in Chrome.
When all files are complete, reply with a short summary of what you built."
opencode run --standalone --auto --title "identity:$D" -m "$1" "$PROMPT" > "rearch/logs/identity_$D.log" 2>&1
echo "exit=$?" >> "rearch/logs/identity_$D.log"
