# popfix: double surface in popups/command + action sheet density

Branch `feat/ui-popup-sheet-fix` (worktree `dashcn-w-popfix`, docs port 8879).

## Root cause

Two overlay helpers stacked a dialog card behind an inner surface that already
draws its own border, so two bordered rectangles painted around the same items:

- Home command card (`docs/lib/widgets/collage_home_menus.dart`): `showDialog`
  (dialog card: `card` fill, 1px `border`, `p-6` padding, `shadowLg`) wrapping a
  `Command` palette (own 1px `border`, `p-1` list padding, `shadowLg`). The gap
  between the two borders in the screenshot is the dialog `p-6` padding.
- Wide action sheet (`showActionSheet` wide path): `showDialog` with the default
  dialog theme wrapping `ActionSheet` (own surface, own density padding). Same
  stacking: dialog border + padding behind the sheet surface, so the sheet
  looked oversized with double padding.

Inline previews (`MenuPopup`, `DropdownMenu`, `Command`, `Menubar`,
`NavigationMenu` panel) already paint exactly one visible full border each.
Verified with the new `popup_single_surface_test.dart`: it counts only
`DecoratedBox` full rectangular borders (all four sides, width > 0), ignoring
the invisible `width: 0, style: none` focus placeholders and the command search
field bottom divider. Before the fix the overlay doubles painted 2 full borders
in the same tree; after the fix each overlay paints 1.

Nesting rule enforced: `showPopup`/`showDropdown`/`showMenu`/`showContextMenu`
provide the single `MenuPopup` surface and builders must return bare content
(rows, not another surface). `showCommandDialog` already used a transparent
dialog shell; the home card now uses it too.

## Every component fixed

- `docs/lib/widgets/collage_home_menus.dart` (`HomeCommandCard`): replaced
  `showDialog` + `SizedBox(width: 320, child: Command(...))` with
  `showCommandDialog` (transparent dialog shell, `maxWidth: 320`). Single
  palette border. Removed the now-unused dialog import.
- `dashcn/lib/src/components/action_sheet/action_sheet_show.dart` (wide path):
  transparent `DialogTheme` (transparent fill, `borderWidth: 0`,
  `padding: EdgeInsets.zero`, `maxWidth: null`, no shadows) so only the
  `ActionSheet` surface paints. Mirrored to `docs/lib/ui/dashcn/` via
  `sync_registry.sh`.
- `dashcn/lib/src/components/action_sheet/action_sheet.dart`: compact default
  row floor 40 (Material dense list) instead of the generic token 32; icon 16,
  horizontal/vertical padding and max width stay on density tokens
  (`overlayMaxWidth` 320 compact, `horizontalPadding` 12, `verticalPadding` 6).
  Header stays compact (title 14 semibold max 2 lines, message 13 max 3 lines,
  gaps 4/8). Touch phones still resolve 48 via `resolveDensityTokens`.
- Single-surface tests: new
  `dashcn/test/registry/components/popup_single_surface_test.dart` (8 tests:
  popup, dropdown_menu, menu, command, context_menu closed, menubar,
  navigation_menu content list, action_sheet borderless). Each asserts exactly
  one visible full border (or zero for the borderless sheet, proving no second
  bordered surface).

No changes to `popup`, `dropdown_menu`, `menu`, `context_menu`, `menubar`,
`navigation_menu` inline rendering: already single, now pinned by tests.

## Action sheet sources

- Apple HIG Action sheets: sparing use, short single-line titles, message only if needed, Cancel at bottom, destructive at top in red, avoid scrolling. (https://developer.apple.com/design/human-interface-guidelines/action-sheets)
- WWDC20 Design with iOS pickers, menus and actions: menus replaced action sheets on iPhone; keep action sheets for destructive confirmations needing finger-travel friction. (https://developer.apple.com/videos/play/wwdc2020/10205/)
- Material Design 3 Bottom sheets: modal sheets for long menus, max width on large screens, height from content, internal scroll past 50% height. (https://m3.material.io/components/bottom-sheets/guidelines)
- Material 1 Bottom sheets spec: list-style sheet margins 16dp sides / 8dp top-bottom, list-item height 48dp, icons 24dp, dense list 40dp height. (https://m1.material.io/components/bottom-sheets.html)
- shadcn/ui Sheet: dialog-based side panel, not an action list; confirms sheet chrome comes from dialog tokens. (https://ui.shadcn.com/docs/components/radix/sheet)
- Paragon Action Sheet: bottom sheet on dialog, `max-w-md` centered, `p-3`, `rounded-2xl` cards, `min-h-12` rows, `text-sm`, icons `size-4` (16px), destructive zoning, separated cancel. (https://www.paragon-ui.com/docs/action-sheet)
- TessinaUI Action Sheet: bottom sheet capped 480px centered, rows meet 44px touch floor, truncated labels, ~12 row ceiling, no scroll. (https://tessinaui.com/docs/action-sheet)

Rules used: compact default, 40px rows + 16px icons (dense list / `size-4`), max width + padding from density tokens (320 / 12+6 compact), centered title/message with tight gaps, no oversized header, transparent dialog shell on wide so the sheet is the only surface, phones full-width bottom sheet.

## Captures

All in `scratchpad/ui/popfix/` (agent-browser, docs on :8879):

- `user_popup_double.png`: user attachment copy (Show popup + Profile/Settings double border).
- `before_popup_1280x800_dark.png`, `before_dropdown_1280x800_dark.png`, `before_command_1280x800_dark.png`: pre-fix inline surfaces (already single inline; the double was in the opened overlays).
- `after_popup_1280x800_dark.png`, `after_dropdown_1280x800_dark.png`, `after_command_1280x800_dark.png`, `after_actionsheet_1280x800_dark.png`, `after_home_1280x800_dark.png`: post-fix, 1280x800 dark.
- `after_*_1280x800_light.png`: same pages, light (system media).
- `after_*_375x812_dark.png`, `after_*_375x812_light.png`: 375x812 phone viewport, both modes.
- `after_actionsheet_375x812_light_inline.png`, `..._inline2.png`: scrolled attempts (Flutter web canvas does not scroll via agent-browser, so inline sheet rows below the fold are covered by widget tests, not pixels).

Overlay open states cannot be clicked via agent-browser (Flutter canvas exposes no accessibility refs); the dialog doubles are proven by the transparent-shell code change plus the single-surface widget tests. Home command dialog now opens via `showCommandDialog` (single border); wide action sheet opens via transparent dialog (single sheet surface).

## Gates

- `dart format --output=none --set-exit-if-changed` on touched files: pass (repo-wide format reports pre-existing changes in untouched tool files).
- `dart run tool/check_names.dart`: 0 hits, exit 0.
- `dart analyze` action_sheet, command, single-surface test: No issues found.
- `flutter test` (one at a time): `popup_single_surface_test` 8/8 pass; `popup_test` 8/8; `dropdown_menu_test` 10/10; `command_test` 11/11; `action_sheet_test` 11/11; `menu_test` 30/30; `context_menu_test` 13/13; `menubar_test` 13/13; `navigation_menu_test` 22/22.
- `docs`: `sync_registry.sh --check` up to date; `gen_docs_data.dart --check` up to date.
- `dart run tool/gen_exports.dart --check`, `gen_registry_manifest --check`, `gen_scorecards --check`, `gen_previews_test --check`, `gen_blocks_test --check`: all up to date after regen (registry.json + scorecards.json regenerated and committed).
- `flutter build web --release --base-href /`: built `build/web`, exit 0.

## PR

PR: https://github.com/mibrar-dev/dashcn/pull/45

Decisions: inline popups were already single (pinned by tests, not reworked); fixed the two overlay doubles (home command, wide sheet) at the source (transparent shell) rather than editing screenshots; action sheet compact row 40 per Material dense + 16px icons per `size-4`, padding/max-width from tokens; Flutter-web scrolling limits noted above.
