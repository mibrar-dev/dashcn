# P8-3 — CLI → `dashcn_cli` / `dashcn` (+ eject, add --package, init mode)

Prerequisite: P8-2 rename map approved (`$KIT/dashcn/tool/rename_map.yaml`). Work ONLY in `$CLI` (the CLI worktree).
Read first: `DASHCN_PACKAGE_PLAN.md` §3 + P8-3, `$CLI/README.md`, `$CLI/PLAN.md`, `$CLI/bin/*.dart`,
`$CLI/lib/src/presentation/cli/**`, `$CLI/lib/src/config/**`, `$CLI/lib/src/application/services/lockfile/**`,
`$KIT/rearch/reports/P8-1.md` (CLI registry-path findings).

## Goal
The CLI becomes package `dashcn_cli` 1.0.0 with a single executable `dashcn`, with no "shadcn" anywhere. It gains
package mode and `eject`.

## Steps
1. Identity: `pubspec.yaml` `name: dashcn_cli`, `version: 1.0.0`, description, `executables: {dashcn: dashcn}`, single
   `bin/dashcn.dart` (`git mv` from `bin/shadcn.dart`; `bin/flutter_shadcn.dart` removed with `git rm`; this is allowed
   for these two files only). `lib/flutter_shadcn_cli.dart` (verify name) → `lib/dashcn_cli.dart`. Version string
   source (verify where `--version` reads it) = 1.0.0.
2. Renames, driven by the kit's rename map plus a CLI addendum `$CLI/tool/rename_map_cli.yaml` (you write it): files
   and classes `shadcn_config` → `dashcn_config`, `ShadcnLock*` → `Lock*`/`DashcnLock*` (plain where no clash),
   lockfile `shadcn.lock` → `dashcn.lock`, config `components.json`/`shadcn.yaml` (verify current names) →
   `dashcn.yaml`, state dir → `.dashcn/`, install dir `lib/ui/shadcn/` → `lib/ui/dashcn/` (still configurable),
   default registry URLs/paths → the kit's new `dashcn/lib/src/...` layout. Use an analyzer-based codemod
   (`$CLI/tool/rename_cli.dart`), not hand edits. Update `templates/**`, `doc/**`, README, CHANGELOG (`## [1.0.0]`).
3. `dashcn add <id> --package`: adds `dashcn: ^1.0.0` (or `path:` when `--path <dir>` is given) via
   `flutter pub add`, writes no sources, records the component in `dashcn.lock` as `mode: package`, prints the import
   (`package:dashcn/components/<id>.dart`).
4. `dashcn eject <id> [--with-deps]`: for a `mode: package` component, copies its sources (+ the transitive registry
   deps not already owned) into the install dir, then rewrites the app's `import 'package:dashcn/components/<id>.dart'`
   (and the barrel when the component was used through it — add an explicit owned import plus a `hide` on the barrel)
   using the analyzer. Lock flips to `mode: copy`. `--dry-run` prints the plan. Refuses on dirty conflicts unless
   `--force`.
5. `dashcn init`: asks "package or own the code?" (non-interactive flag `--mode package|copy`), writes `dashcn.yaml`.
6. Tests: unit (config/lock migration of names, eject import rewriting incl. barrel/`as`/`show` cases) + e2e
   (`test/e2e/`): fresh `flutter create` app → init copy → add button → analyze; init package (path dep to
   `$KIT/dashcn`) → add button --package → analyze; eject button → analyze → no `package:dashcn/components/button.dart`
   import left.

## Owns
Everything in `$CLI` except `.git`. Read-only: `$KIT/**`.

## Gates
In `$CLI`: `dart format --output=none --set-exit-if-changed .`, `dart analyze` (0 issues), `dart test`,
`dart test -t e2e --run-skipped test/e2e/acceptance_test.dart` plus your new e2e files,
`grep -rni shadcn lib bin templates test doc README.md pubspec.yaml | wc -l` → 0 (list any justified exception).

## Report
`$CLI/qa_reports/P8-3.md` (print the RESULT block too).
