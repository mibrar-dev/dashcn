# Contributing components and blocks

How to add or change a dashcn component or block, step by step. Paths are
relative to the repo root; generator commands run from `dashcn/` and docs
commands from `docs/`. See `INSTRUCTIONS.md` for the full layout, layers,
and QA gate.

## Prerequisites

- Flutter `3.47.x` on stable; the kit floor is Dart `^3.12.0`.
- Read `INSTRUCTIONS.md` first (layers, generators, docs sync, releasing).
- Widgets-only: kit sources import `package:flutter/widgets.dart`, never
  `material.dart` or `cupertino.dart`. No `part` directives, no blanket
  `ignore_for_file`.

## Adding a component

1. **Create the directory** `dashcn/lib/src/components/<id>/`, where
   `<id>` is lowercase `snake_case` (e.g. `date_picker`). Keep every file
   under ~300 lines; put helpers next to the widget, not in `_impl/`
   subtrees.
2. **Write the widget** `<id>.dart` with a plain public name (`Button`,
   not `DashcnButton`). Public names must not collide with
   `package:flutter/widgets.dart` — `dart run tool/check_names.dart`
   enforces this.
3. **Write the theme files**: `<id>_theme.dart` (the `<Name>Theme`
   user-replaceable config class) and `<id>_defaults.dart` (the
   `const <Name>Theme <camel>Defaults`). Look at
   `dashcn/lib/src/components/button/button_theme.dart` and
   `button_defaults.dart` as the pattern. Styles resolve via
   `Theme.of(context)` with the defaults as fallback:
   `final ThemeData theme = Theme.of(context);`
4. **Write `meta.json`** with all fields: `id`, `name`, `category` (must
   be a known category in `dashcn/tool/registry/src/categories.dart`,
   e.g. `"Buttons & Actions"`), `description`, `tier: "component"`,
   `install` (`"dashcn add <id>"`), `import`, `tags`, `deps` (per-layer
   lists under `foundation`/`theme`/`primitives`/`components` — they must
   equal the layers the code really imports), `files` (every shipped
   file), `api` (`classes`/`enums`/`functions`/`constants`), and `theme`
   (`class`, `userFile`, `defaults`, `fields`). See
   `dashcn/lib/src/components/button/meta.json` and
   `dashcn/lib/src/components/badge/meta.json`.
5. **Write `preview.dart`** following the preview contract: export
   `const List<ComponentPreview> <camelName>Previews` (e.g.
   `buttonPreviews`), one focused live demo per entry, the first entry
   the default. Import `ComponentPreview` from
   `../../foundation/component_preview.dart`. Split large demo groups
   into `preview_<topic>.dart` files imported by `preview.dart` (like
   `button/preview_status.dart`).
6. **Write `README.md`** in the component dir: what it is, variants,
   theming hooks, one short example.
7. **Regenerate**: `dart run tool/registry/gen_registry_manifest.dart`,
   `dart run tool/gen_exports.dart`,
   `dart run tool/registry/gen_previews_test.dart`. Then confirm clean:
   append `--check` to each and re-run.
8. **Test**: add widget tests under `dashcn/test/registry/components/`
   (`<id>_test.dart`) and QA coverage under
   `dashcn/test/registry/qa/` (`<id>_qa_test.dart`) following the
   existing `<id>_test.dart` / `<id>_qa_test.dart` pairs. Run
   `flutter test test/registry` from `dashcn/`.
9. **Guardrails**: `dart run tool/check_names.dart` and
   `dart run tool/rearch/check_layers.dart --root lib/src` from `dashcn/`
   (imports may only point at the same layer or lower).
10. **Docs sync**: from `docs/`, `bash tool/sync_registry.sh` then
    `dart run tool/gen_docs_data.dart`, and check the component page with
    `flutter run -d chrome`.

## Changing a component

- Edit sources, `meta.json` (`deps`, `files`, `api`, `theme.fields`),
  and `preview.dart` together — the generated manifest test and blocks
  meta test derive real imports with `package:analyzer`, so drift fails
  the gate instead of shipping.
- Re-run the three generators from step 7 above plus
  `dart run tool/gen_scorecards.dart` when visuals change, and update the
  component `README.md`.
- While on `0.x`, breaking API changes ship in a minor bump and are
  listed in `dashcn/CHANGELOG.md`; deprecated APIs stay at least one
  release with a migration path.

## Adding a block

Blocks are layer 4: composed, installable screens/sections built from
components. They may import foundation/theme/primitives/components, never
another block.

1. **Create** `dashcn/lib/src/blocks/<id>/` with a hyphenated id (e.g.
   `dashboard-01`). Files: `<underscored_id>.dart` holding the public
   widget (which is also the preview, e.g. `class Dashboard01`),
   optional `<underscored_id>_<part>.dart` parts, `meta.json`, `README.md`.
   The directory name keeps the hyphen (`dashboard-01/`); the Dart file
   uses underscores (`dashboard_01.dart`).
2. **`meta.json`** fields: `id`, `name`, `category` (a known block
   category in `dashcn/tool/registry/src/categories.dart`, e.g.
   `"Dashboard"`), `description`, `viewport` (`desktop`/`mobile`),
   `install` (`"dashcn add <id>"`), `import`, `tags`, `deps` (same
   per-layer shape as components), `files`. See
   `dashcn/lib/src/blocks/dashboard-01/meta.json`.
3. **Regenerate**: `dart run tool/registry/gen_registry_manifest.dart`
   and `dart run tool/registry/gen_blocks_test.dart` (writes
   `test/registry/blocks/blocks_render_test.dart`, pumping every block
   at 375/768/1440 under the neutral + claude presets in light + dark,
   and `blocks_meta_test.dart`, asserting `meta.json` deps equal the real
   imports). Verify with `--check`.
4. **Test + docs** as in component steps 8–10 (block render tests live
   under `dashcn/test/registry/blocks/`).

Flows (`dashcn/lib/src/flows/<id>/`, e.g. `auth-01/` with `flow.dart` +
`screens/*.dart` + `meta.json` with `entry`, `screens`, and per-layer
`deps` including `blocks`) follow the same regenerate-test-sync loop.

## PR checklist

- [ ] Generators re-run and `--check` clean: `gen_registry_manifest`,
      `gen_exports`, `gen_previews_test`, `gen_blocks_test` (blocks),
      `gen_scorecards` (visual changes).
- [ ] `dart run tool/check_names.dart` clean (no `shadcn` remnants, no
      `widgets.dart` collisions outside
      `dashcn/tool/check_names_allow.txt`).
- [ ] `dart run tool/rearch/check_layers.dart --root lib/src --strict`
      clean (no upward or cross-block imports).
- [ ] `flutter test test/registry` passes from `dashcn/`; new/changed
      behavior has component + QA tests.
- [ ] `bash rearch/qa_gate.sh` green from the repo root.
- [ ] Docs mirror + data in sync (`sync_registry.sh --check`,
      `gen_docs_data --check` from `docs/`); component/block page
      checked with `flutter run -d chrome`.
- [ ] `meta.json` deps/files/api match the code; `README.md` updated;
      CHANGELOG entry for user-visible changes.
