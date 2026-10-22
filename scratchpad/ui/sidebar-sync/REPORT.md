# REPORT — sync feat/sidebar-dashboard with main

Merge of `origin/main` into `feat/sidebar-dashboard` (worktree `dashcn-w-sidebar`).
Branch tip before merge: `ccad7a710`; main: `e58ac25b8`; merge-base: `d024bc482`.
No merge into main performed; this branch only catches up to main.

## Conflicts (4 files, per task)

- `docs/lib/pages/component_page.dart` — WIP badge.
  Kept main's version (`_isWip` + `_WipNote`, from the players work).
  Removed this branch's duplicate (`_workInProgressIds` set with
  audio/video/sidebar and its single long badge). No unused helpers left;
  file is byte-identical to `origin/main` plus merge context.
- `docs/lib/widgets/docs_article.dart` — title-row badge bound.
  Both sides added the same fix (`Flexible(child: badges)` so the badge Wrap
  wraps instead of forcing the 640 px article past overflow). Kept the
  `Flexible` and both comments' intent: main's "Wide branch…" explanation
  plus the branch note that WIP pages carry three badges.
- Generated files — NOT hand-edited:
  - `dashcn/lib/src/manifests/scorecards.json`
  - `docs/lib/generated/docs_scorecards.dart`
  Regenerated via:
  `dart run tool/registry/gen_registry_manifest.dart` (dashcn),
  `dart run tool/gen_scorecards.dart` (dashcn),
  `bash tool/sync_registry.sh` (docs, 924 files mirrored),
  `dart run tool/gen_docs_data.dart` (docs).

## Docs keyboard count fix

`docs/tool/gen_docs_data_test.dart` —
"keyboard tables: rows for calendar, gaps for dialog" failed after the merge:

- Expected: 124 (`kComponents.length - 9` = 133 - 9)
- Actual: 123

Root cause: the sidebar ships a keyboard table in its README/meta
(feeds the docs Accessibility section), so it leaves `kKeyboardGaps`.
Generated data confirms: `keyboard: 123 gaps of 133 components`; the 10
components with rows are toolbar, calendar, autocomplete, radio_group,
segmented_control, wheel_picker, sidebar, audio_player, video_player, app
(9 before + sidebar).

Fix (test-only, generated data untouched): changed the expectation to the
generated-data length rule `kComponents.length - 10` and updated the comment
to "Exactly ten components document keyboard rows (the nine before, plus the
sidebar, which documents its keys)."

## Verify

- `dart format docs/lib/pages/component_page.dart docs/lib/widgets/docs_article.dart docs/tool/gen_docs_data_test.dart`: 0 changed.
- `dart analyze` (root, docs, dashcn): no issues.
- `docs/flutter test tool/gen_docs_data_test.dart`: 35 passed (incl. keyboard test).
- `docs/flutter test test/hero_count_test.dart`: 2 passed.
- `docs/flutter test test/component_examples_test.dart`: 7 passed.
- `dashcn/flutter test test/registry/components/sidebar_test.dart`: 9 passed.

## Commit

Merge commit + fix on `feat/sidebar-dashboard`, pushed. Not merged to main.
