# P9-2a — Live props playground: controls data, code emission, builders

Spec: `DASHCN_FEATURES_PLAN.md` §P9-2 (binding). You work in the MAIN kit worktree; another agent works on flows in a
separate worktree. Read `$DOCS/tool/gen_docs_data.dart` + `$DOCS/tool/src/**` (the API extraction that already produces
`docs/lib/generated/docs_api.dart`), `docs_api.dart` itself, `$DOCS/lib/previews/component_previews.dart`, and the kit
sources of the components listed below (`$APP/lib/src/components/<id>/`).

## Deliverables
1. **Control specs (generated).** Extend the generator to emit `docs/lib/generated/docs_controls.dart`: for each
   component, a list of `ControlSpec` derived from the extracted constructor params:
   `bool` → toggle; enum → select (resolve enum VALUES by scanning enum declarations in `$APP/lib/src/**` with the
   analyzer — unresolved AST is fine since names are unique); `String` → text; `int`/`double` → slider/number (range
   from a manifest/meta.json `playground.ranges` override, else heuristics documented in code); `Color`/theme colour →
   token picker (theme token names); `Widget child` with a text child → text; `VoidCallback?` → "enabled" toggle
   (null vs no-op); everything else → listed as read-only. Optional per-component overrides in the component's
   `meta.json`: `playground: {exclude: [...], ranges: {...}, defaults: {...}, labels: {...}}` (add only where
   needed; document the schema in the kit's meta docs). `gen_docs_data --check` must stay deterministic.
2. **Values + code emission** `docs/lib/playground/`: `PlaygroundValues` (typed map; defaults from the spec;
   (de)serialised to URL query `p.<name>=…`), `emitCode(componentId, spec, values)` producing idiomatic, formatted Dart
   for the current values: only non-default args, enums qualified (`ButtonVariant.outline`), strings escaped,
   `const` when every arg is const, multi-line when > 80 chars, trailing commas, and the right import
   (`package:dashcn/components/<id>.dart`).
3. **Builders** `docs/lib/playground/builders/<id>.dart`: `PlaygroundBuilder` = `Widget build(BuildContext,
   PlaygroundValues)` for these 30 components (verify each exists; skip and report any that don't):
   button, badge, input, text_area, checkbox, switch, radio_group, select, slider, toggle, toggle_group, tabs, card,
   alert, avatar, progress, skeleton, tooltip, dialog (trigger button), popover/popup, dropdown_menu, accordion,
   calendar, date_picker, pagination, breadcrumb, divider, label/form field, keyboard_shortcut (kbd), spinner.
   A registry `kPlaygroundBuilders` maps id → builder. Components without a builder are simply absent (P9-2b shows
   "Playground coming soon").
4. **Tests** `docs/test/playground/`: code emission unit tests (defaults omitted, enum qualification, escaping, const,
   wrapping, import line); URL round-trip of values; for EVERY builder: changing each control changes the rendered
   widget (find by type/semantics) AND the emitted code, and the emitted code is valid Dart (parse it with the
   analyzer's `parseString` in the test); generator `--check` test.

No UI panel in this batch (P9-2b). Do not edit `component_page.dart`.

## Owns
`$DOCS/tool/gen_docs_data.dart` + `$DOCS/tool/src/**` (controls output only), `$DOCS/lib/generated/docs_controls.dart`,
`$DOCS/lib/playground/**`, `$DOCS/test/playground/**`, `playground` blocks in `$APP/lib/src/components/*/meta.json`
(+ regenerate manifest, previews and docs data with the repo's generators).

## Gates
Docs: `dart format --set-exit-if-changed lib test tool`, `flutter analyze`, `flutter test`, `gen_docs_data --check`,
`sync_registry --check`, `flutter build web --release`. Kit (meta.json touched): `rearch/qa_gate.sh`,
`gen_registry_manifest --check`, `dart format --set-exit-if-changed .` in `$APP`.

## Report
`$KIT/rearch/reports/P9-2a.md`
