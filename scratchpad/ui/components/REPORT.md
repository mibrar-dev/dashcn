# REPORT — component sizing and spacing consistency (feat/component-spacing)

Branch `feat/component-spacing`, worktree `dashcn-w-components`, docs on port 8882,
captures in `scratchpad/ui/components/captures/`, inventory in
`scratchpad/ui/components/INVENTORY.md`.

Note: `scratchpad/ui/design/DESIGN.md` does not exist in this worktree. The sizing
reference used is `dashcn/lib/src/theme/density_tokens.dart` (compact default:
control 32, icon 16, row 32-36, hPad 12, vPad 6, gap 8, body 14/sub 13, overlay
160-320; comfortable: control 40, row 40-44; touch: control 48, row 48-56; 4 px
scale), cross-checked against the upstream design system (day cell `h-9 w-9` =
36 px compacted to the 32 compact token), Apple HIG (44 pt touch minimum, 32-40
compact rows, 16 pt icons), and Material density (compact rows 32-40, 48 px touch
targets, FAB small/medium/large 40/56/64).

## Inventory summary

Full table: `scratchpad/ui/components/INVENTORY.md` (132 component dirs swept for
`DensityTokens` use, token fields, `EdgeInsetsDensity`, hardcoded min/max heights
and icon sizes; curated rows for the ten fix areas).

- Token-driven already: swipe_actions, action_sheet, list_tile, skeleton, filter_bar.
- Fixed to tokens: calendar (constants), fab (icons + shadows), menu (row padding),
  table (header/row heights), swipe (label size + width floor).
- Documented exceptions (kept, on-scale): action_sheet compact row 40 (touch-target
  exception; phones resolve 48 touch), menubar triggers 48 (touch floor; popup rows
  stay 32), fab boxes 40/56/64 (Material 3; mini matches tokens 32/40/48), menu
  16 px check gutter and fixed label/separator insets (upstream fixed geometry),
  input default 36 (the "default" density control height).
- Flagged (not in scope, not changed): tabs trigger 30, audio/video transport 48/56
  (media SPEC sizes).

## What changed

1. Calendar (`calendar_style.dart`, tests): day 48 -> 32, month 56x48 -> 48x32;
   weekday header follows as one cell. Tests updated (pitch 4*36, thresholds 272 px).
2. FAB (`fab_style.dart`, `fab.dart`, `preview.dart`): standard icons 18/24/28 ->
   16/20/24 (density tokens, <= 60% of box); hand-rolled `BoxShadow` formula ->
   `tokens.shadows` (elev 3 -> shadowLg, 2 -> shadowMd, per-instance shadowColor
   tints the token geometry); preview rebuilt with enabled buttons (old previews
   were disabled/dimmed) plus a Mini sizes example.
3. Swipe actions (`swipe_actions*.dart`, `preview.dart`, tests): labels 12 -> 13
   (subtitle token); action width 48 px touch floor clamp (explicit `actionExtent`
   and theme widths); previews 56 -> 36 compact rows; custom circle 56 -> 32.
   Reveal already stretches to the row height.
4. Action sheet / list tiles: no code change needed — both already resolve every
   pad from the same tokens (verified; row 40 compact exception documented).
5. Table (`table_style.dart`, `preview.dart`, tests): header 40 -> 36; previews
   `defaultRowHeight` 44 -> 36 (frame math updated); invoices example converted to
   scrollable + resizable (was static). Resize was already wired via
   `ResizableTableController` + `CellResizer` (column reallocate, row expand).
6. Filter bar (`filter_bar_style.dart`, `filter_bar_dialog.dart` new,
   `filter_bar_body.dart`, `filter_bar.dart`, `filter_bar_overflow.dart`,
   `meta.json`, `preview.dart`, tests): new `popup` (canonical anchored compact
   menu; `menu` kept as legacy alias) and `dialog` (centred via `showDialog`)
   variants + `openFilterBarDialog`; default presentation autoMenu -> inline;
   preview shows Popup, Dialog, Sheet + open-menu examples; popup + dialog open
   tests added.
7. Menu/menubar (`menu_style.dart`, `menu.dart`, `meta.json`, tests): new
   `menuItemPaddingOf(tokens, scale)` (gap 8 x vPad 6); `_plainRow` uses tokens
   unless the theme overrides; submenu flips to the trigger's left edge
   (alignment topEnd/anchor topStart, offset -8,-4) when right edge + 160 px would
   overflow; row-padding regression test added.
8. Skeleton (`skeleton_test.dart`): shimmer already loops via
   `RepeatedAnimationBuilder` + `controller.repeat()` (motion-scaled, parked under
   reduced motion); added `loop` group proving card/list/table differ across two
   frames.
9. Popup/dropdown: already exactly one border (single `Border.all` in
   `MenuPopupSurface`, borderless `GlassSurface` wrapper); verified by the existing
   `popup_single_surface_test.dart` (8 tests green, incl. dropdown + menubar).
10. Inventory + outliers: `INVENTORY.md` written; outliers above fixed or documented.

Generated: `lib/dashcn.dart`, `lib/components/filter_bar.dart` (dialog export),
`lib/src/manifests/registry.json` + `scorecards.json`, docs mirror + `docs_data`.

## Captures

49 files in `scratchpad/ui/components/captures/`, index in `CAPTURES.md`: every
page at 1280x800 and 375x812, light and dark (`<comp>-<WxH>-<theme>-top.png`),
plus `filter_bar-1280x800-light-variants.png` (With-chips + Popup live examples).
Overlay-open and gesture states are canvas-unclickable, so they are covered by
widget tests (menu padding, filter_bar popup/dialog opens, swipe 48 px floor,
table divider-drag tests, skeleton loop tests).

## Gate codes

- `dart format --output=none --set-exit-if-changed lib test tool` (dashcn) -> 0 changed.
- `dart analyze lib/src` (dashcn) -> No issues found.
- `flutter test test/registry/components/{skeleton,calendar,fab,swipe_actions,table,filter_bar,filter_bar_density,menu,menubar,popup,popup_single_surface,dropdown_menu,action_sheet,list_tile,menu_test,swipe_actions_test added cases}_test.dart` -> all pass, run one at a time.
- `flutter test test/registry/previews_test.dart` -> 580 pass.
- `flutter test test/registry/qa/previews_centered_test.dart` -> 387 pass.
- `flutter test test/rearch` -> 42 pass.
- `dart run tool/check_names.dart` -> 0 hits.
- `dart run tool/gen_scorecards.dart --check` -> up to date (96 components).
- `dart run tool/registry/gen_registry_manifest.dart --check` -> up to date.
- `dart run tool/gen_exports.dart --check` -> up to date (158 libraries).
- `dart run tool/registry/gen_previews_test.dart --check` -> up to date (96 components).
- `bash tool/sync_registry.sh --check` (docs) -> mirror is up to date.
- `dart run tool/gen_docs_data.dart --check` (docs) -> up to date (18 files).
- `dart format` (docs lib) -> 0 changed.
- Push: `git push -u origin feat/component-spacing` (no force-push).

## Deliver

- PR: https://github.com/mibrar-dev/dashcn/pull/52 (base main, NOT merged).
- Trailer used: `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`
- Browsers/servers: session `w-components` closed (`close --all`); docs server on
  :8882 killed after captures.
- Suggested follow-up: tabs 30 px trigger + audio/video 48/56 transport audit;
  docs API table Description-column clipping at 1280 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
