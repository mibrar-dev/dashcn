#!/usr/bin/env bash
# Snapshot a worktree's uncommitted work (tracked changes + new files, .gitignore respected) to
# `wip/autosave-<name>` on origin WITHOUT touching the working tree, the index or the current branch.
# Use it so in-flight agent work survives if this machine/container goes away.
#
# Usage: rearch/autosave_wip.sh <name> [repo-dir]     (repo-dir defaults to this kit worktree)
# Restore elsewhere: git fetch origin wip/autosave-<name> && git checkout -b <branch> FETCH_HEAD
#   (the snapshot is ONE commit on top of the worktree's HEAD at snapshot time; its message records that HEAD).
set -euo pipefail
name="${1:?usage: autosave_wip.sh <name> [repo-dir]}"
repo="${2:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$repo"
head="$(git rev-parse HEAD)"
branch="$(git branch --show-current || true)"
idx="$(mktemp)"
trap 'rm -f "$idx"' EXIT
export GIT_INDEX_FILE="$idx"
git read-tree HEAD
git add -A .
# Test runs rewrite these reference PNGs; they are never real changes.
git reset -q HEAD -- rearch/screenshots/pilot rearch/design/ours/screens 2>/dev/null || true
tree="$(git write-tree)"
unset GIT_INDEX_FILE
if [ "$tree" = "$(git rev-parse "HEAD^{tree}")" ]; then
  echo "autosave $name: nothing uncommitted (HEAD $head on ${branch:-detached})"
  exit 0
fi
commit="$(git -c user.name="dashcn autosave" -c user.email="noreply@anthropic.com" commit-tree "$tree" -p "$head" \
  -m "autosave($name): uncommitted work on ${branch:-detached} @ ${head:0:7} ($(date -u +%FT%TZ))")"
git push -q --force origin "$commit:refs/heads/wip/autosave-$name"
echo "autosave $name: pushed $(git diff --name-only "$head" "$commit" | wc -l) changed files -> wip/autosave-$name ($commit)"
