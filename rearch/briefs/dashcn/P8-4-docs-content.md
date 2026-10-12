# P8-4 — Docs content: brand, install modes, Material interop, READMEs

Read: `DASHCN_PACKAGE_PLAN.md` §1–§3 + P8-4, `DASHCN_FEATURES_PLAN.md` §0, `$KIT/RELEASING.md`, the CLI README
(`$CLI/README.md`, read-only) for exact commands, `docs/lib/pages/**`, `docs/lib/routing/**`, `docs/README.md`,
`docs/pubspec.yaml`, the repo `README.md`, `dashcn/README.md`. You work in the MAIN worktree; another agent's flows
branch will be merged in later (do not touch `dashcn/lib/src/flows/**` or `components/swipe_actions/**`).

## Tasks
1. **Brand leftovers** (P8-2 left these to you): `docs/pubspec.yaml` (description/comments), `docs/README.md`,
   `docs/analysis_options.yaml` comments, `docs/.gitignore` (`.shadcn/cache/` → `.dashcn/cache/`), `docs/Makefile`
   (drop or rename the stale `generate_shadcn_barrel.py` target — verify it exists; if the script is gone, remove the
   target), `docs/public/llms-full.txt` (regenerate with its generator if one exists, else rename strings),
   `docs/superpowers/**` is historical: leave it. The repo root `README.md` becomes the dashcn README (logo from
   `brand/svg/lockup-on-light.svg` with a dark-mode `<picture>` source, one-line pitch, install both ways, links to docs,
   CLI, RELEASING, licence; keep badges but point them at the real repo `mibrar-dev/shadcn_flutter_kit` until the
   rename). Other root docs (`REARCHITECTURE_PLAN.md`, `REGISTRY_CONTRIBUTING.md`, `INSTRUCTIONS.md`, `FUTURE_*`,
   `current_vs_target_*`): rename user-facing names (package, CLI, paths, class names) only where they describe the
   current system; leave historical narrative.
2. **Install tabs** on Getting Started / Installation and on every component page's install block: two tabs —
   "Package" (`flutter pub add dashcn` + `import 'package:dashcn/components/<id>.dart';`) and "Own the code"
   (`dart pub global activate dashcn_cli` then `dashcn init` + `dashcn add <id>`), plus a one-line "switch later with
   `dashcn eject <id>`" note. Reuse the existing install block widget; one source of truth for the command strings.
3. **New pages** (routes + nav under Docs): "Package or own the code?" (when to choose which, how eject works, how
   updates differ, lock file) and "Using dashcn alongside Material" (name clashes: `Theme`, `ThemeData`, `Card`,
   `Dialog`, `Switch`, `showDialog`… — `import 'package:dashcn/dashcn.dart' as ui;` / `hide`, a mixed-app example,
   `DashcnApp` vs `MaterialApp` at the root). Code samples must compile: add a test that extracts every Dart sample
   on these pages and parses it with the analyzer (`parseString`, inside a function body when it is an expression).
4. **CLI reference**: regenerate the docs CLI reference from the current CLI (`$CLI`, via the existing
   `docs/tool/cli_snapshot.txt` mechanism) so it lists `eject`, `add --package`, `init --mode`, `theme import|export`.

## Gates
Docs: `dart format --set-exit-if-changed lib test tool`, `flutter analyze`, `flutter test test tool`,
`gen_docs_data --check`, `sync_registry --check`, `flutter build web --release`; kit `dart run tool/check_names.dart`
(README/doc changes must stay at 0 hits outside the allow-list). Screenshots of the two new pages + an install block
(light/dark) → `../rearch/screenshots/p8-4/` relative to docs (wrap like the real app; do not open them).

## Report
`$KIT/rearch/reports/P8-4.md`
