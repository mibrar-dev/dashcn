# Registry Scripts

Scripts for the post-cutover flat package tree (`lib/src/`).

`src/categories.dart` is the single source of truth for the two P6-B1
taxonomies (component categories and block categories) and for the viewport
hints a block may declare. `gen_registry_manifest.dart` and
`tool/rearch/check_layers.dart` both read it, so a typo in a `meta.json`
category fails the gate instead of reaching the docs.

## Generated manifest

`lib/src/manifests/registry.json` (schemaVersion 2) is the single
registry manifest the CLI reads. Regenerate it after any change to the
registry tree:

- `dart run tool/registry/gen_registry_manifest.dart` — writes the manifest
  from `components/*/meta.json`, `blocks/*/meta.json`, the
  foundation/theme/primitives layers, `themes/*.json` and `pubspec.yaml`.
  Deterministic; `--check` exits 1 when the file on disk is stale. It also
  rejects an unknown component category, an unknown block category or
  viewport, and a block directory without a `README.md` or entry file.
- Build logic: `src/registry_manifest.dart` (+ `src/layer_scan.dart`,
  `src/dart_imports.dart`, `src/categories.dart`). Contract:
  `rearch/reports/registry_manifest.v2.schema.json`.
- Guard: `test/rearch/registry_manifest_test.dart` (up to date + schema +
  dependency closure).

## Blocks

`lib/src/blocks/<id>/` is layer 4, above components: `<id>.dart`
(the public widget, which is also the preview), optional
`<id>_<part>.dart` parts, `meta.json` and `README.md`. A block may import
foundation/theme/primitives/components, never another block.

- `dart run tool/registry/gen_blocks_test.dart` — writes
  `test/registry/blocks/blocks_render_test.dart` (every block pumped at
  375/768/1440 under neutral + claude, light + dark) and
  `test/registry/blocks/blocks_meta_test.dart` (meta.json category,
  viewport, files, and deps == the real imports, derived here with
  `package:analyzer`). `--check` exits 1 when either file is stale.
- `tool/rearch/check_layers.dart` adds `block-imports` (a block importing
  another block) and `block-installable` (self-contained block directory).

Note: the Dart file stem is the id with `-` replaced by `_`, so
`dashboard-01` lives in `dashboard_01.dart` — Dart file names must satisfy
the `file_names` lint.

## Playground overrides (`meta.json`)

A component's `meta.json` may carry an optional `playground` block that tunes
the docs live-props playground (P9-2). The registry manifest ignores the
block, so edits here never drift `registry.json`; the docs codegen
(`docs/tool/gen_docs_data.dart` → `lib/generated/docs_controls.dart`) reads
it straight from `meta.json`:

```json
"playground": {
  "exclude": ["onHover"],
  "ranges": {"size": {"min": 8, "max": 96, "step": 4}},
  "defaults": {"placeholder": "Pick one"},
  "labels": {"child": "Label"}
}
```

- `exclude`: parameter names with no control at all (not even read-only).
- `ranges`: slider bounds per `int`/`double` param (`step` optional).
  Without an override the generator uses name heuristics (`value`/`progress`
  → 0..1, page counters → 1..10, `size`/`gap`/… → 0..64 px, thin strokes →
  0..8, else int 0..100 / double 0..10).
- `defaults`: default values in Dart-source shape (`true`, `3`,
  `'Label'`, `ButtonVariant.primary`). Only needed when the constructor
  default is a non-literal expression the generator cannot decode (it then
  omits the argument, which stays correct but hides the default).
- `labels`: control labels per parameter (default: Title Case of the name).

The kind mapping itself is fixed in `docs/tool/src/controls_build.dart`:
`bool` → toggle, kit `enum` → select, `String` → text, `int`/`double` →
slider, `Color` → theme-token picker, text-like `Widget` slots → text,
`onPressed`/`onLongPress` → one shared `enabled` toggle; infrastructure
params (`key`, `BuildContext`, controllers, theme/style objects) are
skipped, everything else is read-only with a reason.

## Public libraries

- `dart run tool/gen_exports.dart` — generates the public entry points from
  `lib/src/manifests/registry.json`: `lib/dashcn.dart` (barrel: foundation +
  theme + primitives + every component; blocks are NOT included),
  `lib/foundation.dart`, `lib/theme.dart`, `lib/primitives.dart`,
  `lib/components/<id>.dart` and `lib/blocks/<id>.dart`. Ambiguous exports
  are resolved with generated `hide` combinators (declared names come from
  `package:analyzer`) and printed. `--check` exits 1 when a library is stale.

## See also

- `tool/rearch/` — layers/single-owner/user-theme guardrails and
  `gen_app_theme.dart` (preset → `app_theme.dart`).
