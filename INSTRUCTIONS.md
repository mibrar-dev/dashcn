# dashcn contributor instructions

How this repo is laid out, how the registry fits together, and which
commands prove a change is good. Commands below are run from the repo root
unless a `cd` is shown. Every path and command here was verified against
the current tree.

## Prerequisites

- Flutter `3.47.x` on stable (CI pins `channel: stable`,
  `flutter-version: '3.47.x'` in every workflow; local check at time of
  writing: Flutter 3.47.7, Dart 3.13.5).
- The kit package requires Dart `^3.12.0` (`dashcn/pubspec.yaml`).
- `rsync` (the docs mirror check uses it; CI installs it explicitly).
- No Material/Cupertino in kit sources, ever — the package is
  `package:flutter/widgets.dart` only, plus `flutter_localizations`,
  `intl`, and `expressions`.

## Repo layout

| Path | What it is |
|---|---|
| `dashcn/` | The `dashcn` package (version 0.1.0, not yet on pub.dev). Sources in `dashcn/lib/src/`, public libraries in `dashcn/lib/`. |
| `dashcn/lib/src/foundation/` | Layer 0: `data.dart`, `gap.dart`, icons, style helpers. No kit imports. |
| `dashcn/lib/src/theme/` | Layer 1: `theme.dart` (`Theme`, `ThemeData`, `Theme.of`), tokens, density, typography, `interop/`. |
| `dashcn/lib/src/primitives/` | Layer 2: headless building blocks (`clickable`, `table_layout`, …). |
| `dashcn/lib/src/components/` | Layer 3: 119 component dirs, one per component (`button/`, `badge/`, …). |
| `dashcn/lib/src/blocks/` | Layer 4: 16 composed blocks (`dashboard-01`, `login-01`, …). Never import each other. |
| `dashcn/lib/src/flows/` | Layer 5: 5 multi-screen flows (`auth-01`, `chat-01`, `checkout-01`, `onboarding-01`, `settings-01`). Each owns a nested Navigator. |
| `dashcn/lib/src/starters/` | 3 app starters (`saas`, `chat`, `shop`) used by `dashcn create`. |
| `dashcn/lib/src/themes/` | 43 theme presets (`neutral.json`, `claude.json`, …) plus `index.json` and `themes.schema.json`. |
| `dashcn/lib/src/manifests/` | Generated: `registry.json` (schemaVersion 2, the manifest the CLI reads) and `scorecards.json`. |
| `dashcn/lib/dashcn.dart` | Generated barrel (foundation + theme + primitives + every component; blocks/flows have their own per-id libraries). |
| `dashcn/tool/` | Generators and guardrails (see below). |
| `dashcn/test/registry/` | Component/block/flow/preview/visual tests. |
| `dashcn/test/rearch/` | Manifest, layer, and ownership gate tests. |
| `docs/` | The Flutter web docs app (Widget Catalog), deployed to `https://mibrar-dev.github.io/dashcn/` with base href `/dashcn/`. |
| `brand/` | Logo kit: SVG sources in `brand/svg/` (lockups, marks, wordmarks). |
| `rearch/` | Internal agent working area: plans, briefs, reports, `qa_gate.sh`. Not shipped; screenshots captured here are git-ignored. |
| `licenses/` | Third-party licenses (e.g. the shadcn_flutter BSD-3-Clause original). |
| `.github/workflows/` | `ci.yml` (kit + docs jobs), `docs-deploy.yml` (Pages), `publish.yml` (pub.dev). |

The `dashcn` CLI (`dashcn init`, `dashcn add`, …) lives in its own repo,
[`mibrar-dev/dashcn_cli`](https://github.com/mibrar-dev/dashcn_cli),
as package `dashcn_cli`. It installs from this repo's registry, either as
a package dependency or as copied sources under `lib/ui/dashcn/`.

## Layers and the dependency rule

Layers run foundation → theme → primitives → components → blocks (→ flows,
starters). The rule, enforced by
`dart run tool/rearch/check_layers.dart --root lib/src` (from `dashcn/`),
is: **a file may only import its own layer or lower — never a higher one —
and a block may never import another block** (same for flows). Companion
rules in the same tool reject `material.dart`/`cupertino.dart` imports,
`part` directives, blanket `ignore_for_file`, undeclared manifest
dependencies, and files past the length limit. Run with `--strict` in CI.

## How components are organized

Each component lives in `dashcn/lib/src/components/<id>/`. Example
(`button/`):

```
button/
  button.dart            public widget (class Button)
  button_theme.dart      ButtonTheme (user-replaceable config file)
  button_defaults.dart   const ButtonTheme buttonDefaults
  button_style.dart      style resolution
  button_status*.dart    async status machine
  button_group.dart      connected ButtonGroup
  button_layout.dart     size metrics
  button_variant_style.dart
  meta.json              identity, deps, files, api, theme contract
  preview.dart           docs examples (the preview contract)
  preview_status.dart    status demos (imported by preview.dart)
  README.md              component docs
```

`meta.json` fields: `id`, `name`, `category`, `description`, `tier`,
`install` (`dashcn add <id>`), `import`, `tags`, `deps` (per-layer lists
under `foundation`/`theme`/`primitives`/`components`), `files` (every
shipped file), `api` (`classes`/`enums`/`functions`/`constants`), and
`theme` (`class`, `userFile`, `defaults`, `fields`). Blocks mirror this
with hyphenated ids (`dashboard-01/` holding `dashboard_01.dart`,
`meta.json`, `README.md`).

The preview contract: every component's `preview.dart` exports
`const List<ComponentPreview> <camelName>Previews` (e.g. `buttonPreviews`,
`badgePreviews`), one focused live demo per entry, the first entry being
the default. The docs site renders these directly.

Theming: components read the ambient theme with `Theme.of(context)`
(`final ThemeData theme = Theme.of(context);`) and resolve per-variant
styles through their `<Name>Theme` class with `buttonDefaults`-style
fallbacks. To re-theme one component, replace its single user file
(e.g. `button_theme.dart`) — no multi-file edits.

Naming: public names are plain (`Theme`, `ThemeData`, `Button`,
`FormScope`, `Picture`, `TableView`, `DashcnApp`, …). Nothing exported by
the package may collide with `package:flutter/widgets.dart`. The guardrail
is `dart run tool/check_names.dart` (from `dashcn/`); the few surviving
historical strings are allow-listed in `dashcn/tool/check_names_allow.txt`.

## Generators and their `--check`

All generators are idempotent and support `--check` (exit 1 when the
checked-in output is stale — this is what CI runs). From `dashcn/`:

| Command | Writes |
|---|---|
| `dart run tool/registry/gen_registry_manifest.dart [--check]` | `lib/src/manifests/registry.json` from `*/meta.json`, layers, `themes/*.json`, `pubspec.yaml` |
| `dart run tool/gen_exports.dart [--check]` | `lib/dashcn.dart`, `lib/foundation.dart`, `lib/theme.dart`, `lib/theme_interop.dart`, `lib/primitives.dart`, `lib/components/<id>.dart`, `lib/blocks/<id>.dart`, `lib/flows/<id>.dart` |
| `dart run tool/registry/gen_previews_test.dart [--check]` | `test/registry/previews_test.dart` (+ centered-stage QA test) from every `preview.dart` |
| `dart run tool/registry/gen_blocks_test.dart [--check]` | `test/registry/blocks/blocks_render_test.dart` + `blocks_meta_test.dart` |
| `dart run tool/gen_scorecards.dart [--check]` | `test/scorecards/scorecard_harness_test.dart` + `lib/src/manifests/scorecards.json` |
| `dart run tool/check_names.dart` | No output files; fails on `shadcn` remnants or `widgets.dart` collisions |

After any change to sources, meta files, themes, or presets, re-run the
affected generators without `--check`, then verify with `--check`.

## The QA gate

`rearch/qa_gate.sh` (run from the repo root: `bash rearch/qa_gate.sh`)
runs every registry gate in one pass: format, generated-exports check,
analyze, `flutter test test/registry`, `flutter test test/rearch`, layer /
single-owner / user-theme checks, the banned-pattern grep (no
material/cupertino, no `part`, no `data_widget`/`gap` package imports),
and a stray-files report. Keep it green before opening a PR. Capture tests
under `dashcn/test/registry/visual/` and `dashcn/test/registry/flows/`
write screenshots to `rearch/screenshots/` and `rearch/design/`; those
outputs are git-ignored (see `.gitignore`) and must never be committed.

## Docs app (`docs/`)

The docs app mirrors the registry the way the CLI installs it
(`docs/lib/ui/dashcn/…`), then code-generates its data. From `docs/`:

```bash
bash tool/sync_registry.sh            # mirror dashcn/lib/src -> lib/ui/dashcn
dart run tool/gen_docs_data.dart       # rebuild lib/generated/*.dart + preview registries
flutter run -d chrome                 # local preview
flutter build web --release --base-href /dashcn/   # production build (matches Pages)
```

Both scripts support `--check` (`bash tool/sync_registry.sh --check`,
`dart run tool/gen_docs_data.dart --check`); CI runs the checks plus
format, analyze, tests, and the release web build.

## CI workflows

- `ci.yml` — `kit` job (from `dashcn/`: format, analyze, `flutter test
  test/registry test/rearch test/tool test/scorecards`, scorecards/exports
  `--check`, `check_names`, the three registry generators `--check`,
  layer/owner/theme guardrails, `dart pub publish --dry-run`) and `docs`
  job (from `docs/`: install, `sync_registry.sh --check`,
  `gen_docs_data --check`, format/analyze/test, release web build).
- `docs-deploy.yml` — builds `docs/` and deploys to GitHub Pages
  (`baseHref: /dashcn/`) on pushes to `main`.
- `publish.yml` — on tags `v[0-9]+.[0-9]+.[0-9]+*`, fails unless the tag
  equals `v<dashcn/pubspec.yaml version>`, then publishes via pub.dev OIDC
  (`environment: pub.dev`, `id-token: write`).

## Releasing

How `dashcn` (and the `dashcn_cli` companion) reach pub.dev. Current
version: 0.1.0 (not yet on pub.dev).

**Semver policy.** The first release is `0.1.0`, published from scratch
(no upgrade path from the old code-copy layout). While on `0.x`, a minor
bump (`0.2.0`) may break the public API and a patch bump (`0.1.1`) never
does; breaking changes are listed in the CHANGELOG. `1.0.0` follows an API
review once the plain names (`Theme`, `ThemeData`, `DashcnApp`, …) have
been used in real apps; from then on breaking changes need a new major
version. A deprecated API stays for at least one release with a documented
migration path before removal.

**One-time pub.dev setup (by hand, Ibrar).** Automated publishing uses
GitHub OIDC — no secrets. For each package, open its pub.dev admin page
and add an "Automated publishing" entry:

| Package | Repo | Workflow | Tag pattern | Environment |
|---|---|---|---|---|
| `dashcn` | `mibrar-dev/dashcn` | `publish.yml` | `v{{version}}` | `pub.dev` |
| `dashcn_cli` | `mibrar-dev/dashcn_cli` | `publish.yml` | `v{{version}}` | `pub.dev` |

The `publish.yml` workflows pass `environment: pub.dev`, so create a
`pub.dev` environment in each repo's settings (required reviewers
recommended). If a package was never published, the first publish can be
done from a checkout (`dart pub publish`) to create the listing, then
automation takes over.

**Release order.** 1. **Kit first.** Tag the kit `v0.1.0`: the CLI's
default registry pins `mibrar-dev/dashcn@v<cli version>/dashcn/lib/src`,
so a published CLI only works with defaults when the matching kit tag
(with the `dashcn/` layout) exists. 2. Verify `dashcn` on pub.dev, then
tag the CLI `v0.1.0` in its repo.

**Pre-tag checks.** Set the CHANGELOG entry date in
`dashcn/CHANGELOG.md` (and `CHANGELOG.md` in the CLI repo). Run every
gate: kit `rearch/qa_gate.sh` plus all `--check` generators,
`check_names`, docs format/analyze/test plus `gen_docs_data --check`,
`sync_registry.sh --check` and the release web build, CLI
format/analyze/unit/e2e. CI runs the same on the tag push, but a red tag
still sends publish notifications — keep tags green. Then `git tag
v0.1.0`, push the tag (`publish.yml` fails unless the tag equals
`v<pubspec version>`), and write GitHub Release notes from the CHANGELOG
entry. Never publish from a laptop except for the one-time listing
creation; never push tags for versions not in the CHANGELOG.
