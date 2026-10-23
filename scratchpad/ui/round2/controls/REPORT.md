# Controls and tiles sizing — REPORT (fix/sizing-controls-tiles)

Notes folder: `scratchpad/ui/round2/controls` (captures in `captures/`).
Branch: `fix/sizing-controls-tiles` (worktree `dashcn-w-controls`).

## 0. Design spec note (SIZING.md missing)

`scratchpad/ui/design/SIZING.md` does **not** exist in this worktree
(no `scratchpad/ui/design/` directory; no `round2/` before this task).
I proceeded from the task's explicit numbers and the theme tokens, which
cover every value used:

- Spacing scale (4 px base): 4 / 8 / 12 / 16 / 24 / 32 (`kSpace1/2/3/4/6/8`).
- Density tokens: control 32 / 40 / 48, rowMin 32 / 40 / 48,
  rowMax 36 / 44 / 56, icon 16 / 20 / 24, hPad 12 / 14 / 16,
  vPad 6 / 8 / 12, gap 8 / 10 / 12, body 14 / 15 / 16, subtitle 13 / 14 / 15,
  overlay 160–320.
- Shadows from `Theme.tokens.shadows` (`shadowLg` for elevated surfaces,
  `shadowMd` for mini).
- Same sizes on desktop and mobile throughout: components resolve the
  ambient `Theme.densityTokens` directly (no phone-width touch switch);
  touch comfort is the invisible `TouchHitArea` (iOS 44 / Android 48),
  never larger visuals. `resolveDensityTokens` itself is unchanged, so its
  phone-width unit test still passes.

## 1. Measured sizes (after fix, px)

Measured with `tester.getSize` (compact default theme) and theme constants.
Touch platforms add invisible hit padding around the same painted visuals
(e.g. a 36 px button lays out 48 px tall on Android via `TouchHitArea`).

| Control | Measured |
|---|---|
| Button sm / md (default) / lg | 32 / **36** / 40 (xs 28; icon 36×36). Painted visuals; hit area grows invisibly on touch. |
| Button beside input | Row capture: input **36**, button **36** — same height. |
| Input | **36** (`inputDefaults.height`). |
| Select trigger | **36** (`triggerMinHeight`). |
| Search field (`SearchBar` input) | **36** (input minHeight; results list opens below). |
| Date field (`DatePicker`/`DateRangePicker` trigger) | **36** (`objectFormTriggerMinHeight`). |
| FilterBar search / sort / date | **36 / 36 / 36** (sort was 48, fixed to 36). Inline, popup, dialog and sheet share `filterBarOverflowContent`, so all variants are 36. Triggers and dialog/sheet/menu clear buttons are `ButtonSize.md` = **36** (were sm 32). |
| `list_tile` single line | **32** (new `minHeight`; was content-driven ~26). |
| `list_tile` two lines | **48** (new `minHeight`; subtitle gap `gap/2` = 4). |
| `swipe_actions` row | Uses list-tile heights: min **32**, two-line content grows to **48**. |
| `swipe_actions` action tile | At least **64** wide (`max(control+24, 64)`: 64 / 64 / 72; was 56 / 64 / 72). Full-row-height run (`Row` stretch cells); labels at subtitle **13** (readable, `maxLines: 1`, ellipsis). Row content not clipped (tiles constrained to row height, text truncates inside tile). |
| Calendar day cell | **32** (`calendarDayCellSize`, now `× scaling` only — no density scaling). |
| Calendar header controls | **32** (`calendarDayCellSize × scaling`; chevrons + caption share the grid pitch). Gap **4**, shell `p-3` = **12**. |
| FAB small | **40** box, **16** icon. |
| FAB default extended | **56** pill, **16** icon + label (extended icons now always 16; standard round keeps 16 / 20 / 24). |
| FAB shadow | Token shadows (`elevation 3 → shadowLg`, mini `2 → shadowMd`). |
| FAB Customized example | Now visible: secondary fill, radius **16**, `gap 8`, `elevation 3` (was flat `elevation 0`, radius 8, gap 6). |
| Table header / rows | **40 / 40** (`tableHeaderCellDefaults`/`tableCellDefaults.minHeight`; were 36 / none). Preview controllers and demo boxes updated 36 → 40. Columns resize by dragging the header divider (`ResizableTableController` + `CellResizer`, thickness 4, `table_resize` handles; covered by `table_test` resize cases). At 375 px the grid scrolls horizontally inside its frame via `ScrollableClient` (`table-375.png` shows `# / Name / Role / Status` with horizontal scroll; Status is reachable, nothing cut off). |
| `action_sheet` | Keeps inner padding (16 horizontal/vertical from `gap×2`); adds **16** (`kSpace4`) top breathing room above the title and **8** (`kSpace2`) below the last row. |
| `filter_bar` variants | Inline + popup + dialog + sheet all **36** (see FilterBar row above). |

Before → after deltas: sort control 48 → 36; triggers/clear 32 → 36;
list-tile single content-height → 32, two-line → 48; swipe tile 56 → 64
(compact); calendar density-scaled → fixed 32; fab extended icon 20 → 16;
customized flat → shadowed; table 36 → 40; action sheet +16 top / +8 bottom;
phones (touch preset 48/56 visuals) → same 36/32/48 visuals as desktop with
invisible hit areas.

## 2. Captures (`captures/`, 17 PNGs)

Closed triggers plus every OPEN state (open menus/popups/dialogs/sheets and
swiped rows):

- `controls-button-input-row.png` — button beside input, both 36.
- `select-closed.png` / `select-open.png` — closed trigger (36) and open popup rows.
- `search-open.png` — search field (36) with ranked results open.
- `list-tile-single.png` (32) / `list-tile-two.png` (48).
- `swipe-closed.png` / `swipe-open.png` — closed row and swiped-open run (64 px Archive/Delete, full row height, readable labels).
- `calendar.png` — 32 px day grid; `date-dialog-open.png` — picker dialog with 32 px header controls over the grid.
- `fab-sizes.png` (40 small, 56 default), `fab-extended.png` (56 pill, 16 icon + label), `fab-customized.png` (visible, shadowed).
- `table-375.png` — 40 px header/rows at 375 px width, horizontal scroll inside the frame (Status reachable).
- `action-sheet-open.png` — sheet with 16 top / 8 bottom breathing room.
- `filter-bar-inline.png` — inline 36 px controls; `filter-dialog-open.png` — dialog/sheet body with the same 36 px search/sort/date controls (popup/menu/sheet share `filterBarOverflowContent`, so the same heights apply; menu/popup chrome uses the same 36 px clear action).

Note: `select-open.png` renders the popup rows standalone (a `SelectItem`
outside `Select` logs a `RovingRow` scheduler assertion in the harness, but
the PNG still captures the open rows; the committed test suite has no such
harness and is green).

## 3. Gate results

- `dart format`: clean (touched kit files + updated tests formatted).
- `flutter analyze` (dashcn): **No issues found**.
- `dart run tool/check_names.dart`: **0 hits**.
- `flutter test` (one at a time, touched areas — all pass):
  - `button_test` 12/12, `list_tile_test` 12/12, `swipe_actions_test` 16/16
    (2 expectations updated: tile width 56→64 compact, 48→64 floor; ListView drag −50→−70 for the wider tile),
  - `calendar_test` 86/86, `fab_test` 16/16, `table_test` 27/27,
  - `action_sheet_test` 12/12, `filter_bar_test` 20/20 (sort size 48→36),
  - `filter_bar_density_test` 9/9, `input_test` 23/23, `select_test` 22/22,
  - `search_bar_test` 30/30, `date_picker_test` 19/19.
- Generators: `gen_registry_manifest`, `gen_exports`, `gen_previews_test`,
  `gen_blocks_test`, `gen_scorecards` regenerated and `--check` clean;
  `scorecards.json` (97 components) up to date.
- Docs mirror: `sync_registry.sh` mirrored 924 files, `--check` clean;
  `gen_docs_data` regenerated, `--check` clean (18 files).
- Docs: `flutter analyze` clean; `flutter build web --release --base-href /dashcn/` **✓ Built build/web**.
- Full `flutter test test/registry test/rearch` was not run end-to-end here
  (per instruction: tests one at a time); the touched-area suites above plus
  the `--check` generators are green. `rearch/qa_gate.sh` remains for CI.

## 4. Files changed (kit + tests + previews)

- `button/button.dart` — ambient tokens (no phone switch); visuals 32/36/40 everywhere, hit area invisible.
- `list_tile/list_tile.dart` — 32 single / 48 two-line `minHeight`, leading capped to row height, body centered; ambient tokens.
- `swipe_actions/*` — 64 px minimum tile, readable 13 px labels, list-tile row heights, ambient tokens; previews updated to 32 px rows / 64 px tiles.
- `calendar/calendar.dart` — fixed 32 px cells + 32 px header (`× scaling` only).
- `fab/fab_style.dart`, `fab/preview.dart` — extended icons 16; Customized visible (radius 16, gap 8, elevation 3 → `shadowLg`).
- `table/table_style.dart`, `table/preview.dart` — header/rows 40; demos 40 with header-divider resize + 375 px horizontal scroll.
- `action_sheet/action_sheet.dart` — +16 top, +8 bottom, inner padding kept; ambient tokens.
- `filter_bar/*` — search/sort/date fixed 36 on all variants; triggers + dialog/sheet/menu clear at 36 (`md`); ambient tokens.
- Tests updated to the new scale: `swipe_actions_test` (64 widths/floor, drag −70), `filter_bar_test` (sort 36).

## 5. Push / PR

Branch `fix/sizing-controls-tiles` pushed without force; PR opened with
`gh pr create --repo mibrar-dev/dashcn --base main` (body ends with
"🤖 Generated with [Claude Code](https://claude.com/claude-code)"). Not merged,
per instructions. Trailer: `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.
