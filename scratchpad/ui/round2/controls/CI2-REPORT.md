# PR 60 CI fix round 2 — REPORT (fix/sizing-controls-tiles)

Notes folder: `scratchpad/ui/round2/controls` (`REPORT.md` + `REPORT_CI_FIX.md` + `captures/` kept).
Branch: `fix/sizing-controls-tiles` (worktree `dashcn-w-controls`).
Trailer: `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

## SIZING.md

Kept `scratchpad/ui/design/SIZING.md` unchanged. Design rule kept: controls
36 px visual, same desktop/mobile visuals; touch comfort via invisible hit
area, never larger visuals.

## 1. Chat flow (`dashcn/test/registry/flows/chat_01_flow_test.dart`)

Failure: `walk light/dark ltr/rtl` → `swipe row never settled open`
(`flows_support.dart:105`).

Cause: sizing commit bumped the swipe tile floor 56 → 64 px
(`swipeActionWidthForTokens`: `max(control+24,64)`; compact 32+24=56 → 64).
The chat walk still expected 2×56=112, so the drag revealed 0.79 and the
settle poll looked for -112 while the row settles at -128.

Fix (no weakening, same strict translate check): `_actionsWidth` 112 → 128
(2×64 readable tiles), comment updated. Same fix as checkout walk (56→64)
in round 1.

## 2. Select popup anchoring (`responsive_popups_test.dart`)

Failure: `select anchored at 1024.0/768.0` → gap 18.0, expected ≤12.
`popup Rect(50,152,218,194) trigger Rect(62,114,182,134)`.

Cause: round-1 `TouchHitArea` (Select + `ObjectFormField`) grew layout
36→48 on touch (`flutter test` runs as Android: 6 px/side). The popover
anchored to the outer box (`_SelectState.context`), while the test measures
the inner 20 px placeholder. Gap = (48-20)/2 + 4 offset = 18 vs 12 before
(8 centering + 4 offset).

Fix (source, no test weakening):
- `select.dart`: added `_triggerAnchorKey` (on the painted `Clickable`,
  36 px visual) and anchor via
  `_triggerAnchorKey.currentContext ?? context`. Popup offset stays
  `Offset(0,4)`; gap back to 8+4=12 on mobile and desktop.
- `object_form_field.dart`: same pattern (`_triggerAnchorKey` on inner
  `Clickable`, `_showPopover` anchors to it) so date/time pickers stay
  within 12 px too.

## 3. `TouchHitArea` dual mode (fixes 5 component failures without weakening)

Round-1 growing `Padding` broke visual-size tests that pin 36/32 while
`button_test` ("touch platforms grow the hit box") and `card_image_test`
(6 px inset) pin growth. Both are correct for their contexts.

Fix: `TouchHitArea(growLayout: true|false)` (default true = buttons,
growing `Padding`, layout 48, `getSize` 48):
- `growLayout: false` (select + object-form triggers beside inputs):
  new `_TouchHitExpander`/`_RenderTouchHitArea` — layout stays visual
  (36/32, `getSize` unchanged, rows stay aligned), only `semanticBounds`
  and hit test expand to 48/44. Scorecard `androidTapTarget`/`iOSTapTarget`
  (which read `SemanticsNode.rect`) still pass; direct touches in the
  overflow forward to the child.
- `Button`/`CardImage` keep growing; select/pickers use non-growing.
- `ThemeData.touchTargets` doc updated for both modes.

This fixes (no test edits): `color_picker` (Select 36), `filter_bar_density`
(custom 32), `p7f3_input_polish` ×3 (pickers match inputs at 36 visual,
semantics 48).

One test update (aligns measurement to visual, not weakening):
- `filter_bar_test.dart`: `FilterBarSortControl` 180×48 → 180×36 with
  comment (paints/measures 36, reports 48 via semantics). Round-1 had set
  48 for the growing outer; non-growing keeps layout 36 like search.

## 4. Table + calendar reverts (fixes 2 more component failures)

Sizing commit changed behavior the tests intentionally pin:
- `table_style.dart`: header `minHeight` 40 → 36, body removed added
  `minHeight: 40` (back to no minimum). Test pins `h-9` 36 compacted from
  upstream `h-10` 40. `preview.dart` `defaultRowHeight` 40 → 36 and heights
  40→36 to match.
- `calendar.dart`: `_densityScale` `theme.scaling` → 
  `theme.density.scale * theme.scaling` (density-scaled 16/32/40 cells,
  not fixed 32). Test pins density scaling.

No test edits; sources restored to pinned behavior.

## 5. Regeneration / verification

- `dart run tool/registry/gen_registry_manifest.dart`
- `dart run tool/gen_exports.dart`
- `dart run tool/registry/gen_previews_test.dart`
- `dart run tool/registry/gen_blocks_test.dart`
- `dart run tool/gen_scorecards.dart` (97 components, 0 failures)
- `docs: bash tool/sync_registry.sh`, `dart run tool/gen_docs_data.dart`
- All `--check` clean; `dart format` clean; `flutter analyze` clean
  (`dashcn/` + `docs/`).
- Required suites, all green:
  - `dashcn flutter test test/registry/flows` ✓ 76/76
  - `dashcn flutter test test/registry/responsive_popups_test.dart` ✓ 28/28
  - `dashcn flutter test test/registry/components` ✓ 2816/2816
  - `docs flutter test test/scorecard` ✓ 11/11
    (`scorecards_page_test: no checks are exempt; every row passes` ✓)

## Files changed

- `dashcn/lib/src/components/select/select.dart` (+anchor key, non-growing)
- `dashcn/lib/src/primitives/form_core/object_form_field.dart` (+anchor,
  non-growing)
- `dashcn/lib/src/primitives/touch_hit_area.dart` (dual mode + render proxy)
- `dashcn/lib/src/theme/theme.dart` (doc)
- `dashcn/lib/src/components/table/table_style.dart` + `preview.dart`
  (36 revert)
- `dashcn/lib/src/components/calendar/calendar.dart` (density scale revert)
- `dashcn/test/registry/flows/chat_01_flow_test.dart` (112→128)
- `dashcn/test/registry/components/filter_bar_test.dart` (180×48→180×36)
- Generated: `registry.json`, `scorecards.json`, docs mirrors +
  `docs/lib/generated/*`
- Added: this `CI2-REPORT.md` (`SIZING.md` untouched)
