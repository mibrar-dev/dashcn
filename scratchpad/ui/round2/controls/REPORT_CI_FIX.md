# PR 60 CI fix — REPORT (fix/sizing-controls-tiles)

Notes folder: `scratchpad/ui/round2/controls` (existing `REPORT.md` + `captures/` kept).
Branch: `fix/sizing-controls-tiles` (worktree `dashcn-w-controls`).
Trailer: `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

## SIZING.md

Restored `scratchpad/ui/design/SIZING.md` in this worktree (copied from the
parent checkout container). No content changes. Design rule kept: controls
36 px visible, touch comfort via invisible hit area, never larger visuals.

## 1. Checkout walk (`dashcn/test/registry/flows/checkout_01_flow_test.dart`)

Failure: `walk light/dark ltr/rtl` → `swipe row never settled open` at
`settleSwipeOpen` (flows_support.dart:105).

Cause: sizing commit bumped the swipe tile floor 56 → 64 px
(`swipeActionWidthForTokens`: `max(control+24,64)`; compact 32+24=56 → 64).
The flow test still expected 56 (`_actionsWidth = 56`), so the drag
(70.4 px) revealed 0.79 and the settle poll looked for -56 while the row
settles at -64.

Fix: updated `_actionsWidth` 56 → 64 (same as `swipe_actions_test` which
already moved drag -50 → -70 and expectations to 64). No flow screen changes
were needed: with 64 the full walk (cart → address sheet → payment → success,
plus fling dismiss and form-error cases) passes light/dark × ltr/rtl.
Cart/address/payment screens already handle the new heights (Expanded
ListView, PinnedSheet, SingleChildScrollView); no overflow.

## 2. Scorecards (`docs/test/scorecard/scorecards_page_test.dart`)

Failure: `no checks are exempt; every row passes` → `filter_bar failures`
(Expected 0, Actual 2: `androidTapTarget` + `iOSTapTarget`).

Cause: sizing commit fixed `FilterBarSortControl` 48 → 36 px visible.
Scorecard harness measures 180×36 for label "Newest" (Select trigger),
failing 48 (Android) / 44 (iOS). `Button` already passed via `TouchHitArea`
(Clear-all node 158×48); `Select` and `ObjectFormField` (date trigger) had
no hit area.

Fix (visible stays 36, hit area reaches 48):
- `dashcn/lib/src/components/select/select.dart`: added
  `Semantics(button:true) > TouchHitArea(vertical) > IntrinsicWidth > Clickable`.
  `touchVertical = max(0,(touchMinEdge(platform)-triggerHeight)/2)` (36→48
  = 6 px/side on Android, 4 px/side on iOS; desktop unchanged). `Clickable`
  itself still measures 36, so existing `select_test` (Clickable 36×220)
  still passes.
- `dashcn/lib/src/primitives/form_core/object_form_field.dart`: same pattern
  (`Semantics > TouchHitArea > sized`), `objectFormTriggerMinHeight` 36 →
  48 on touch. `date_picker_test` (`>=36`) still passes.
- `dashcn/test/registry/components/filter_bar_test.dart`: updated
  `FilterBarSortControl` expectation 180×36 → 180×48 (touch; `flutter test`
  runs as Android). Search field (Input text field) stays 220×36.

After fix the harness reports `filter_bar` android/iOS tap targets pass;
`select` and `date_picker` still pass; full `scorecards.json` has 0 failures.

## 3. Regeneration / verification

- `dart run tool/registry/gen_registry_manifest.dart` (also picks up the
  prior action_sheet format + new touch_hit_area dep)
- `dart run tool/gen_exports.dart`
- `dart run tool/registry/gen_previews_test.dart`
- `dart run tool/registry/gen_blocks_test.dart`
- `dart run tool/gen_scorecards.dart` (filter_bar now passes; 97 components)
- `docs/tool/sync_registry.sh` (mirrors select + object_form_field to docs)
- `dart run tool/gen_docs_data.dart` (from `docs/`, 18 files)
- All `--check` variants clean.
- `dart format` clean on touched files.
- `flutter analyze` clean in `dashcn/` and `docs/`.
- Tests run one at a time (per instructions):
  - `dashcn flutter test test/registry/flows/checkout_01_flow_test.dart` ✓ 12/12
  - `docs flutter test test/scorecard/scorecards_page_test.dart` ✓ 4/4
  - Plus: `select_test` ✓, `date_picker_test` ✓, `filter_bar_test` ✓,
    `filter_bar scorecard` harness ✓.

## Files changed

- `dashcn/lib/src/components/select/select.dart` (+TouchHitArea)
- `dashcn/lib/src/primitives/form_core/object_form_field.dart` (+TouchHitArea)
- `dashcn/test/registry/components/filter_bar_test.dart` (180×48 touch)
- `dashcn/test/registry/flows/checkout_01_flow_test.dart` (64 px tile)
- Generated: `registry.json`, `scorecards.json`,
  `docs/lib/generated/docs_scorecards.dart`, docs mirrors
- Added: `scratchpad/ui/design/SIZING.md` (restored, unchanged)
- Added: this `REPORT_CI_FIX.md`
