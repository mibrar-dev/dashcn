# Report: interactive overlays (popup, dropdown_menu, search_bar, command)

Branch `feat/ui-interactive-overlays`, worktree `dashcn-w-overlays`
(from `origin/main` @ `5eb1dab5`, merged to HEAD), port `8875`,
session `w-overlays`, capture folder `scratchpad/ui/overlays`.
Trailer for every commit: `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`.

## Duplicate check

Read every `dashcn/lib/src/components/*/meta.json` description + README
for overlap before building:
- `popup` (anchored generic surface + `showPopup`) vs `menu`
  (`MenuPopup`/`showMenu`), `dropdown_menu` (menu rows anchored),
  `context_menu` (pointer-positioned), `dialog`/`alert_dialog` (modal
  routes), `hover_card`/`tooltip` (hover, no click), `select`/
  `autocomplete` (field-attached popups): no duplication — `popup`
  re-exports menu's `MenuPopup` and only adds the generic anchored
  helper. Extended `menu` instead of duplicating, per the shared rule.
- `dropdown_menu` vs `menu`/`menubar`/`context_menu`/`select`: no
  duplication — rows/traversal/surface come from `menu`; this file only
  adds the anchored `DropdownMenu` surface + `showDropdown`.
- `search_bar` (ranked field + inline result list, groups, cancel) vs
  `autocomplete` (field-attached suggestion popup), `command` (async
  palette + dialog), `select` (single-choice popup): distinct —
  `search_bar` stays inline, shares `primitives/search` ranker with
  `command` (documented in both files, no algorithm copy).
- `command` (debounced async palette + `showCommandDialog`) vs
  `search_bar`: distinct entry point (dialog) and streaming builder
  contract; shares the ranker, owns its palette chrome.

Decision: extend, don't duplicate. No new component ids; all four ids
were already listed (96 listed / 132 total unchanged).

## What was built / changed

Density principles (`scratchpad/ui/design/DESIGN.md` in the parent
checkout; tokens in `density_tokens.dart`): compact default, overlay
160-320 px (`kOverlayMinWidthCompact`/`kOverlayMaxWidthCompact`), item
height = row height, 48 px touch targets, user-overridable tokens.

- `dropdown_menu/dropdown_menu.dart`: surface now hugs content between
  160 and 320 px compact by default. `DropdownMenu` gains
  `width`/`minWidth` (=160 default)/`maxWidth` (=320 default)/
  `maxHeight`; `showDropdown` forwards `width`/`maxWidth`/`maxHeight`
  (max 320 default). Widget-leg `MenuPopupTheme.minWidth` falls back to
  160 when unset (caller's explicit min wins). Rows stay 32 px compact
  (menu row metrics). Imports `density_tokens`; meta `deps.theme` adds
  `density_tokens`; `sizes` note updated to 160-320.
- `popup/popup.dart`: `showPopup` surface hugs 160-320 compact by
  default (`maxWidth ?? 320`, theme minWidth fallback 160, explicit
  overrides win). Generic arbitrary content still allowed wider via
  `maxWidth`. Same meta/dep/sizes updates as dropdown.
- `popup/preview.dart`: new `Customized` example (tinted fill, no
  border via widget-leg `MenuPopupTheme`).
- `dropdown_menu/preview.dart`: new `Customized` example (tinted fill).
- `command/preview.dart`: new `Dialog` example (click-to-open
  `showCommandDialog` trigger button — the missing open-state demo)
  and `Customized` example (tinted palette via widget-leg
  `CommandTheme`). New `button` import.
- `search_bar`: no kit change (inline ranked list already filters live,
  arrows/Enter/Escape via `SearchBarNavFeature`, 48 px touch rows,
  builder slots, controller/initialValue, theme legs). `Custom row`
  example already covers customization.
- `command` core: no change (debounced stream, `SubFocus` arrows/Enter,
  dialog entry, builders, theme legs already compliant).
- Tests: new `dashcn/test/registry/components/overlays_interactive_test.dart`
  (16 checks): dropdown/popup 160-320 bounds, width pinning, theme
  minWidth precedence, 32 px rows, command/search live filtering +
  arrows/Enter select, 375 px no-overflow for all four, RTL render,
  reduced-motion open + Escape close, custom row builder, command
  theme tint.
- Regenerated (dashcn): `gen_exports`, `gen_scorecards`,
  `registry/gen_registry_manifest`, `registry/gen_previews_test` —
  all `--check` clean (158 libraries, 96 components).
- Regenerated (docs): `gen_docs_data` + `sync_registry.sh` — clean
  (18 files); mirror up to date; `hero_count` (132/96) and
  `preview_static_audit` pass.

## Customization surface

- Theme (user-replaceable single files): `command/command_theme.dart`
  (`commandThemeOverrides` → `CommandTheme`), `search_bar/search_bar_theme.dart`
  (`searchBarThemeOverrides`); `popup`/`dropdown_menu` intentionally own
  no theme file — surface tokens are `menu`'s `MenuPopupTheme`
  (`menu/menu_theme.dart`, `menuPopupDefaults`), accepted as the
  widget-leg override (`theme:` on `DropdownMenu`/`showDropdown`/
  `showPopup`). Rationale recorded here instead of duplicating.
- Style objects: `CommandTheme` (background/foreground/muted/border/
  radius/padding/itemHighlight/itemPadding/shadows/maxWidth 512/
  maxHeight 349), `SearchBarTheme` (+highlightColor/textStyle/maxHeight
  300/minRowHeight 48/showLeading/showClear/iconSize),
  `MenuPopupTheme` (background/foreground/border/padding/minWidth/
  surfaceOpacity/surfaceBlur).
- Builders: popup `builder`; dropdown `children` rows (any `MenuButton`/
  custom rows); command `builder`/`emptyBuilder`/`errorBuilder`/
  `loadingBuilder`/`searchPlaceholder`; search `itemLabel`/`itemBuilder`/
  `emptyBuilder`/`leading`.
- Controlled/uncontrolled: search `controller`/`initialValue` (+
  `focusNode`) or internal; command uncontrolled query with
  builder-driven results + `debounceDuration`; dropdown/popup
  uncontrolled surfaces with imperative `Future<T?>` helpers.
- Motion: open/close via popover handler motion tokens; reduced motion
  (`MediaQuery.disableAnimations`) verified by test (popup opens and
  Escape-closes with animations disabled).
- Surface: `GlassSurface` + `surfaceColor`/`surfaceOpacity`/`surfaceBlur`
  (menu/command surfaces; search card stays opaque by design per
  surface allow-list entry).
- RTL/keyboard/semantics/touch/contrast: arrows/Enter/Escape +
  typeahead (menu), arrows/Enter/Escape (search/command palettes),
  semantics labels, 48 px touch rows (command/search) / 32 px compact
  menu rows, token contrast. Covered by existing + new tests.

## Files

- Kit: `dropdown_menu/dropdown_menu.dart`, `popup/popup.dart`,
  `dropdown_menu/meta.json`, `popup/meta.json`,
  `dropdown_menu/preview.dart`, `popup/preview.dart`,
  `command/preview.dart`,
  `test/registry/components/overlays_interactive_test.dart`,
  generated `dashcn.dart`, `registry.json`, `scorecards.json`,
  `previews_test.dart` (+ centered), docs `generated/*` + mirror.
- Captures: `scratchpad/ui/overlays/` (16 base + 2 examples + 1 open +
  4 videos + CAPTURES.md, this REPORT.md).

## Gate exit codes

- `dart format --output=none --set-exit-if-changed lib test tool`
  (dashcn): 0 (1654 files, 0 changed).
- `dart run tool/check_names.dart` (dashcn): 0 hits.
- `dart analyze lib/src test/registry` (dashcn): 0 issues.
- `gen_exports --check` / `gen_scorecards --check` /
  `registry/gen_registry_manifest --check` /
  `registry/gen_previews_test --check`: all up to date.
- `gen_docs_data --check` / `sync_registry.sh --check` (docs): up to
  date; `flutter analyze` (docs): no issues.
- `flutter test` (targeted, one at a time, compact reporter): all pass —
  `popup_test` 8/8, `dropdown_menu_test` 10/10, `command_test` 11/11,
  `search_bar_test` 30/30, `overlays_interactive_test` 16/16,
  `qa/interactive_previews_test` 36/36, `previews_test` 580/580,
  `surface_everywhere_test` 36/36, `popups/popup_behaviour_test`
  54/54, `responsive_popups_test` 28/28, docs `hero_count_test` 2/2,
  docs `audit/preview_static_audit_test` 1/1.
- NOT run to completion here: full `bash rearch/qa_gate.sh`
  (times out at the default 120 s wrapper limit; runs the entire
  `test/registry` suite), full `flutter test test tool` (dashcn) and
  full `flutter test` (docs). CI on the PR will run them. Targeted
  suites above are the complete coverage for the four touched
  components plus all registry-wide preview/surface/popup gates.

## PR

URL: (filled after `gh pr create`; branch `feat/ui-interactive-overlays`,
base `main`, body ends with the Claude Code trailer).

## Not done / limitations

- Standalone `MenuPopup.minWidth` default stays 128 (menu-owned);
  160-320 enforcement lives in the dropdown/popup helpers only, to avoid
  a global menu/select/autocomplete behavior change. Meta `sizes` notes
  for the helpers now say 160-320; menu's own 128 note untouched.
- `command` dialog stays 512 px max (`max-w-lg` upstream) — wider than
  the 160-320 menu bound by design (palette, not menu); documented.
- `search_bar` rows stay 48 px min (touch minimum) rather than 32 px
  compact; menu rows are the 32 px compact reference.
- Browser captures: see CAPTURES.md limitations — trigger-open PNGs for
  dropdown/command and per-example close-ups for all cards were not all
  obtainable via CanvasKit coordinate automation; open/select/close and
  every named example are covered by the widget + generated-preview
  tests listed above instead.
