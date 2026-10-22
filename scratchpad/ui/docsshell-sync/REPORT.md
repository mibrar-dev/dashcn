# docsshell-sync REPORT — merge origin/main into feat/docs-shell-fixes

Branch `feat/docs-shell-fixes`, worktree `dashcn-w-docsshell`. Do NOT merge to main.

## Merge

- `git fetch origin main; git merge origin/main`
- HEAD (branch): `9874df0` style(docs): format charts gallery for CI
- Theirs (origin/main): `e58ac25` feat(ui): polish audio/video players (disc, details, minimal bars, WIP) (#51)
- Merge base: `59d8684` feat(spacing): compact density sizing across components (#52)
- Only 1 commit behind (`e58ac25`); 9 commits ahead on branch.

## Conflicts (3 files, all resolved, no hand-edits to generated files)

1. `docs/lib/pages/component_page.dart`
   - Merge placed main's WIP block (`_isWip` + `_WipNote`) inside the playground
     panel `Column` and left `titleActions` without WIP.
   - Resolution per task: keep main's WIP implementation, remove branch duplicate.
     - `titleActions` now has main's block:
       `if (_isWip(component.id)) ...[Badge(WIP), _WipNote()]`
     - Removed the mis-placed WIP block from the playground panel.
     - Kept `_isWip` + `_WipNote` helpers from main (only users: titleActions).
     - Imports: kept branch's `button`, `dialog as dashcn_dialog`, `gap` plus
       `theme` (both sides); removed `<<<<<<<`/`=======`/`>>>>>>>` markers.
   - Verified: `grep` shows WIP only in titleActions (line ~183) + helpers;
     panel has no WIP.

2. `dashcn/lib/src/manifests/scorecards.json` + `docs/lib/generated/docs_scorecards.dart`
   - Regenerated, not hand-edited (see below).

3. `docs/lib/widgets/docs_article.dart`
   - No action needed: branch had no changes vs base; auto-merge kept main's
     `Flexible(child: badges)` fix (WIP note is widest badge child, wraps to
     second line instead of forcing Row past 640). Working tree equals
     `origin/main` for this file — keeps both sides intent.
   - `docs/lib/widgets/docs_sidebar.dart`: auto-merged, keeps main's WIP chip
     (`_isWip` on `/docs/components/audio_player|video_player`).

## Regeneration (in order)

From repo root / package dirs:

- `cd dashcn && dart run tool/registry/gen_registry_manifest.dart`
  → `dashcn/lib/src/manifests/registry.json`
- `cd dashcn && dart run tool/gen_scorecards.dart`
  → `test/scorecards/scorecard_harness_test.dart (96 components)`,
  → `lib/src/manifests/scorecards.json (96 components)`
- `docs/tool/sync_registry.sh` → mirrored 920 Dart files into `docs/lib/ui/dashcn`
- `cd docs && dart run tool/gen_docs_data.dart`
  → components: 132 (96 listed), keyboard: 123 gaps of 132, wrote
  `docs_data`, `docs_api`, `docs_controls`, `docs_tables`, `docs_search`,
  `docs_snippets`, `docs_blocks`, `docs_flows`, `docs_starters`,
  `docs_preset_sources`, `docs_previews`, `docs_example_sources`,
  `docs_scorecards`, `app_theme`, `component_previews`, `block_sources`,
  `block_previews`, `flow_sources`.

`git add` on the 3 unmerged paths after regeneration; `grep -r "<<<<<<<"` clean.

## Verification

- `dart format` on changed files (docs + dashcn mirrors): 0 changed.
- `dart analyze` in `docs/`: No issues found.
- `dart analyze` in `dashcn/`: No issues found.
- `cd docs && flutter test tool/gen_docs_data_test.dart`: 35 passed.
- `cd docs && flutter test test/hero_count_test.dart`: 2 passed
  (kStats.components=132, listed=96 — matches regen output).
- `cd docs && flutter test test/component_examples_test.dart`: 7 passed
  (~3 min).
- `cd dashcn && flutter test test/registry/components`: 2806 passed.
- Keyboard-count: `kKeyboardGaps.length == kComponents.length - 9`
  (123 == 132-9) — covered by `gen_docs_data_test.dart`, passed, no fix needed.

## Commit

Merge concluded with `git commit` (merge commit, no rebase, no force-push),
trailer `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`,
pushed to `feat/docs-shell-fixes`. Branch NOT merged to main.
