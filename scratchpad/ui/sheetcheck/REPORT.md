# sheetcheck: action sheet open-state padding verification

Branch `feat/ui-popup-sheet-fix` (worktree `dashcn-w-popfix`, docs on :8879).
Follows `scratchpad/ui/popfix/REPORT.md` (sources: Apple HIG action sheets,
WWDC20 pickers/menus/actions, M3 bottom sheets, M1 bottom sheets spec,
shadcn/ui Sheet, Paragon + TessinaUI action sheets; rules: compact default,
40px rows + 16px icons, max width + padding from density tokens, centered
title/message with tight gaps, transparent dialog shell on wide, full-width
bottom sheet on phones).

## Method

- Rebuilt docs web (`cd docs && flutter build web --release --base-href /`),
  served `docs/build/web` on port 8879.
- agent-browser session `w-sheetcheck`: Flutter web canvas exposes no `@eN`
  refs, so semantics were enabled first (`focus` + `Enter` on the "Enable
  accessibility" placeholder), then the real preview buttons were clicked
  (`Open action sheet`, `Delete item`, `Many actions`, on-this-page
  `Compact`/`Comfortable`). No audio played; the session was closed at the end.
- Measured with `getBoundingClientRect` on the `flt-semantics-host` nodes
  (sheet group, title/message, rows, dividers, cancel). Icons are 16px from
  `tokens.iconSize` (code + pixels); inner label rects are not exposed to
  semantics, so row text inset is derived from code (outer + row padding).

## Before (pre-fix, Trigger open, 1280 dark)

Sheet group `480,204 320x226`; title `492,210 296x16`; actions area
`492,253 296x122`; rows `296x40` (Edit/Share/Delete/Cancel); dividers
`296x1`; cancel gap 9 (8 + 1); top/bottom inset 6.

Problem: the sheet shell carried horizontal `tokens.horizontalPadding` (12)
AND every row carried its own horizontal 12, so row text sat 12 + 12 = 24px
from the sheet edge (rule: sides 12-16, no double padding), and the dividers
were inset 12px instead of full-bleed. Single surface was already fine
(transparent dialog shell, no second border).

## Fix

`dashcn/lib/src/components/action_sheet/action_sheet.dart` (mirrored to
`docs/lib/ui/dashcn/` via `sync_registry.sh`), all from density tokens:

- Shell padding is now vertical-only (`tokens.verticalPadding`, 6 compact),
  so rows/dividers span the full sheet width.
- Title/message wrappers carry their own horizontal `tokens.horizontalPadding`
  (12 compact), keeping the header inset single.
- Rows keep their own horizontal/vertical token padding (12/6); dividers are
  now full-bleed; cancel gap unchanged (`tokens.gap` 8 + 1px divider).
- Also corrected the Compact preview message (`Row 32-36` -> `Row 40`).

## After (post-fix, all open states captured)

Trigger 1280 dark: sheet `480,287 320x226`; title/message `492,... 296`
(12 sides); actions area `480,336 320x122` full width; rows `320x40`
full width (text inset single 12); dividers full-bleed; cancel gap 9;
top/bottom inset 6. Max width 320 = compact `overlayMaxWidth`.
Destructive 1280 dark: sheet `480,328 320x144`; Delete row `480,377 320x40`;
Cancel `480,426 320x40`, gap 9; destructive red zoning kept.
Long 1280 dark: 12 uniform ~40px rows, full-bleed dividers, separated Cancel,
internal scroll (pixels).
Compact inline 1280 dark: rows `320x40` full width (explicit compact tokens).
Comfortable 1280 dark/light: ~360 sheet (`overlayMaxWidth`), 40-44 rows,
14/8 padding from comfortable tokens.
Phones 375 (bottom sheet, full-width): Trigger sheet `0,472 375x340`, rows
`375x48` (touch via `resolveDensityTokens`); Destructive + Long same path
with red zoning / internal scroll; Compact inline stays 40px (explicit
override). Light = same layout, light colors (Trigger + Comfortable).

Rules check: compact rows 40 (48 touch phones) ✓; icons 16 ✓; sides 12
single (14 comfortable, 16 touch) ✓; no double padding ✓; max width
320/360, full-width phones ✓; cancel separated (9px) ✓; single borderless
surface (transparent wide dialog) ✓.

## Captures (`scratchpad/ui/sheetcheck/`)

- `open_trigger_1280x800_dark.png`, `open_trigger_1280x800_light.png`
- `open_trigger_375x812_dark.png`, `open_trigger_375x812_light.png`
- `open_destructive_1280x800_dark.png`, `open_destructive_375x812_dark.png`
- `open_long_1280x800_dark.png`, `open_long_375x812_dark.png`
- `open_compact_1280x800_dark.png`, `open_compact_375x812_dark.png`
- `open_comfortable_1280x800_dark.png`, `open_comfortable_1280x800_light.png`

Coverage note: every overlay example shares one `showActionSheet` path and one
`ActionSheet` widget, so the 375 + light variants proven on Trigger
(bottom-sheet path, colors-only change) apply to Destructive/Long; all
screenshots were eyeballed.

## Gates

- `dart format` on the 4 touched files: applied (2 changed), clean after.
- `dart analyze` action_sheet (registry + docs mirror): No issues found.
- `flutter test test/registry/components/action_sheet_test.dart`: 11/11 pass.
- `flutter test test/registry/components/popup_single_surface_test.dart`:
  8/8 pass (action_sheet borderless single surface still holds).
- `docs gen_docs_data --check`: up to date (regenerated after the preview
  message change); `sync_registry --check`: up to date.

Not merged (per instructions).
