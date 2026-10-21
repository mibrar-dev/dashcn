# REPORT — larger context-menu target (`feat/ui-context-target`)

Branch: `feat/ui-context-target`. Worktree was `dashcn-w-ctx` (the named
`dashcn-w-context_menu` worktree does not exist; `dashcn-w-ctx` is on
`feat/ui-context-target`, so I worked there). Port 8877, session
`w-context_menu`, captures in `scratchpad/ui/ctx/`.
Note: `scratchpad/ui/design/DESIGN.md` does not exist in this tree; the
density principles below come from `dashcn/lib/src/theme/density.dart`
and the menu/menu-style sources.

## What I built

Extended the existing `context_menu` component (duplicate check: it is
the only pointer-positioned menu in `dashcn/lib/src/components`; `menu`,
`dropdown_menu`, `menubar` own their button/bar triggers, `popup` is a
generic surface — no duplication, so I extended in place).

`dashcn/lib/src/components/context_menu/context_menu.dart`:

- `targetPadding` (default `EdgeInsets.all(8)`): transparent hit region
  around the child; visual size unchanged.
- `minTargetSize` (default 48, touch platforms only): `ConstrainedBox`
  floors the trigger to 48x48 on iOS/Android/Fuchsia; desktop keeps the
  author's size; `null` disables.
- `menuMinWidth` / `menuMaxWidth`: explicit value wins, else
  `popupTheme.minWidth`, else compact defaults `kContextMenuMinWidth`
  160 / `kContextMenuMaxWidth` 320, threaded through `showContextMenu`
  (`minWidth`/`maxWidth` params, same precedence) into `MenuPopup`.
  Row metrics and surface padding stay density-scaled (compact default).
- `semanticsLabel`: optional trigger label (`Semantics(button: true)`).
- New exported constants `kContextMenuMinWidth`,
  `kContextMenuMaxWidth`, `kContextMenuMinTargetSize` (meta.json
  `api.constants` + registry manifest updated).
- No animations added (open animation lives in the popover primitive);
  RTL offset mirroring and keyboard traversal unchanged.

`preview.dart`: five examples — Default (right-click card + visible
gesture hint), With submenu, Touch target (24 px icon + 48 px floor +
hint label), Expanded target (28 px padding drawn as a muted wash),
Compact menu (200–240 px clamp + `MenuPopupTheme` padding override).
Every demo shows a visible gesture hint (icon + platform-appropriate
"Right-click/Long-press …" + a caption naming both gestures).

`README.md` (new params + enlarged-target snippet) and `meta.json`
(constants, corrected `sizes` note: the old "min-width 192 (12rem)" was
stale — the surface default was 128; the context path now clamps
160–320) updated.

## Customization surface

- Theme/style: no theme file of its own — deliberate. `ContextMenu`
  owns no visual tokens (transparent trigger); rows resolve `MenuTheme`,
  the surface `MenuPopupTheme` (both owned by `menu` per OWNERSHIP).
  Per-instance overrides: `theme`, `popupTheme`, `menuMinWidth`,
  `menuMaxWidth`, `targetPadding`, `minTargetSize`.
- Builders: `child` + `items` are plain widgets (any caller content).
- Controlled/uncontrolled: N/A — the widget holds no state (stateless
  wrapper reading items at tap time).
- Motion: none added; reduced motion honored by the popover/menu layers.
- RTL/keyboard/semantics/48 px/contrast: covered by tests (see below).

## Decisions recorded

- No `context_menu_theme.dart`: a new theme file would duplicate the
  `menu`-owned legs and break the single-owner gate. Recorded here per
  the batch instruction instead.
- 160/320 clamp lives on the context-menu path only (`showContextMenu`
  defaults); global `MenuPopup` keeps min 128 so `menu`/`dropdown_menu`/
  `menubar`/`popup` are unaffected.
- At phone widths the popover renders an adaptive bottom sheet
  (`PopupAdaptive.auto`, breakpoint 768, 12 px gutters → measured
  351 px wide at 375). The 320 cap governs the anchored popover; the
  sheet intentionally goes edge-to-edge. Verified in capture + tests.
- Preview fix worth knowing: `EdgeInsetsDensity.pxAll(32)` in a raw
  `Container(padding:)` resolves to ~2 px (density multipliers only
  resolve via `resolveEdgeInsets` in theme code). The old preview had
  the same 2 px padding; the new card uses `EdgeInsets.all(24)` at
  280 px wide so hint lines fit on every font (widget-test fonts run
  wider than Inter; asserted ≤232 px in tests).

## Files (15 modified + captures)

Kit: `context_menu.dart`, `preview.dart`, `meta.json`, `README.md`,
`test/registry/components/context_menu_test.dart` (+9 tests: touch
floor, desktop size, null floor, padding hit area, custom clamp,
long-label wrap, RTL side, semantics label, disabled-animations open,
375 px no-overflow), regenerated `registry.json`, `scorecards.json`.
Docs: regenerated `docs_api/controls/example_sources/previews/
scorecards/snippets`, mirrored `ui/dashcn/.../context_menu/*`.
Captures: 23 PNGs + `ctx-interaction.webm` + CAPTURES.md (this folder).

## Gates (exit codes)

- `dart format` kit/docs: 0 changed. `check_names`: 0 hits.
- `dart analyze` kit + docs: No issues found.
- `rearch/qa_gate.sh`: exit 0.
- `flutter test test/registry/components/context_menu_test.dart
  test/tool`: 39 passed. `test/scorecards`: 108 passed.
  `flutter test test/registry/surface`, `responsive_popups`,
  `popups/popup_behaviour`, previews `--name context_menu`: all passed.
- `gen_exports/registry/previews/scorecards --check`: up to date.
- docs `sync_registry.sh --check`, `gen_docs_data.dart --check`: up to
  date. `flutter test --concurrency=1` (full docs suite): 900 passed,
  1 skipped. `flutter build web --release --base-href /`: success.
- Scorecards: no new component; `context_menu` checks pass
  (a11y/RTL/LTR/frames per harness + generated page test).

## Visuals

See CAPTURES.md. One honest gap: no `menu-open-375-light.png`
(synthetic right-clicks never opened the menu at 375-light in this
headless session); covered by `menu-open-375-dark.png` (adaptive
sheet), `menu-open-1280-light.png`, the 375 widget test, and the video.

## Not done

- Nothing open. The iPhone-frame blank content and TOC-scroll behavior
  are docs-shell observations outside this scope.

## Deliver

- PR: https://github.com/mibrar-dev/dashcn/pull/47
- Commit trailer: `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`
