# Figma-style playground: one live preview, editable controls, applied to every example

Branch `fix/playground-controls` (from `origin/main`, merged `origin/fix/playground-replaces-toc` — already contained as `8eadf2a88`; PR #55 still open).

## What changed

- Single live preview: when the playground is open, `ComponentPage` hides the
  left column's duplicate `ComponentPreviewCard`. The playground canvas is the
  preview. The page keeps its description and the full examples list.
  `DocsArticle(hideToc:)` already drops the On This Page column while open.
- Right panel = controls (Figma properties):
  - `docs/lib/playground/ui/groups.dart` (new): `groupEditableControls`,
    `playgroundGroupFor`, `PlaygroundControlGroup` (keyed
    `playground-group-<id>`).
  - `panel_body.dart`: `PlaygroundControlsList` now renders grouped rows;
    `PlaygroundControlsCard` header has Reset (`playground-reset`) + Copy code
    (`playground-copy`, copies `emitCode` output).
  - `playground_panel.dart`: new `inlineControls` flag. The component page's
    380 px panel sets it so controls render inline instead of behind an
    `Edit controls` sheet button. Standalone embeds keep the sheet behaviour.
  - Read-only (`ControlKind.readOnly`) never renders: `playgroundGroupFor`
    returns null, `groupEditableControls` filters `isEditable`. API Reference
    keeps them as documentation.
- Controls drive the whole screen:
  - New `PlaygroundScope(activeComponentId)` (`playground/ui/scope.dart`).
    `ComponentPage` provides it when open; opening clears `p.*` (no cross-
    component leak — router navigation without `p.*` also clears via
    `applyRouteUri`); closing clears; `?p.*` deep links auto-open
    (shareable, survives reload).
  - `ExamplePreviewCard` reads scope + `DocsState.playgroundQuery`. When open
    and query non-empty, every card renders its registered playground builder
    from the same `PlaygroundValues.fromQuery` (bypassing the lazy gate so no
    scroll is needed). Code tabs keep the original per-example sources, so
    deliberate per-example overrides stay documented. When closed or at
    defaults (empty query) the static deferred previews render as before.
- Synthetic Button controls (generator, Button only): `hasIcon` (toggle),
  `iconPosition` (select leading/trailing), `fullWidth` (toggle) via
  `docs/tool/src/controls_build.dart::_injectSyntheticControls`. Builder
  renders default icons + full-width wrapper; emitter writes
  `leading:`/`trailing:` + `SizedBox` wrapper (`playground/builders/button.dart`,
  `playground/code.dart`). Respects `meta.json` playground overrides.
- Panel layout: desktop `Row[Expanded(article), 380px panel]`; phone
  (`<1024`) bottom sheet (`Align.bottomCenter`, 85% height, rounded top).
  All insets use `theme.spacing` (density tokens); no hard-coded 16/12/8.
- Tests (new, not weakened):
  - `test/playground/ui/panel_figma_test.dart`: grouping order + read-hidden,
    Reset/Copy present, 380 px inline without sheet button.
  - `test/component_page_playground_test.dart`: open hides duplicate main
    card (14 → 13 `ExamplePreviewCard`), variant+size reach every `Button`
    (all `outline`/`lg`), read-only never renders, phone bottom sheet.
  - `test/playground/*` synthetic-icon/fullWidth coverage (builder + emitter).

## Control groups

Fixed order, empty omitted. Name takes precedence so `size` selects land in
Size, `status` in State, synthetic `hasIcon`/`iconPosition` in Content.

- Appearance: `select` (variant, …), `colorToken`
- Size: `size` selects, `fullWidth`, `slider` (numeric extents)
- State: `toggle`, `enabled`, `status` select
- Content: `text`, `hasIcon`, `iconPosition`

Button now exposes all four (Appearance: variant; Size: size, fullWidth;
State: enabled, status, autofocus; Content: child, hasIcon, iconPosition).
Read-only (686 fields: 685 current + synthetic shift) hidden from panel.

## Captures (127.0.0.1:8886, `flutter build web --release --base-href /`)

- `captures/button-1280x800-before.png`: Button page closed — main preview
  present, TOC present, no panel.
- `captures/button-1280x800-after.png`: `?p.variant=outline&p.size=lg` —
  panel open (380 px, Close, canvas outline Button, Controls Reset/Copy code,
  Appearance/Variant=outline, Size/Size=lg, State, Content), left duplicate
  removed (Installation directly), TOC replaced.
- `captures/button-375x812-before.png`: phone closed — main preview, no panel.
- `captures/button-375x812-after.png`: phone bottom sheet — Playground Close,
  canvas, Controls Reset/Copy code, Appearance/Size/State, no overflow.
- Widget test `variant and size reach every button example` asserts all
  `PreviewStage` Buttons are `outline`/`lg` (page changes together).

## Gates

- `dart format --output=none --set-exit-if-changed lib test tool` (docs): 0 changed.
- `flutter analyze` (docs): No issues found.
- `dart run tool/check_names.dart` (dashcn): 0 hits.
- `dart run tool/gen_docs_data.dart --check` (docs): up to date (18 files).
- `bash tool/sync_registry.sh --check` (docs): mirror is up to date.
- `flutter test test/playground/values_test.dart`: pass.
- `flutter test test/playground/code_emit_test.dart`: pass.
- `flutter test test/playground/ui/panel_test.dart`: 13 pass.
- `flutter test test/playground/ui/panel_figma_test.dart`: 3 pass.
- `flutter test test/component_page_test.dart`: 13 pass.
- `flutter test test/component_page_playground_test.dart`: 4 pass.
- `flutter build web --release --base-href /`: built `build/web`.

## PR

PR URL: https://github.com/mibrar-dev/dashcn/pull/56
