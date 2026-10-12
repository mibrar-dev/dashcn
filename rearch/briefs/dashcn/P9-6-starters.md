# P9-6 — App starters: `dashcn create <starter> <name>`

Spec: `DASHCN_FEATURES_PLAN.md` §P9-6 (binding). You work in a SECONDARY kit worktree (`$KIT`, branch
`wip/p9-6-starters`) and a SECONDARY CLI worktree — for this task the CLI is **`$ROOT/dashcn-cli-b`** (branch
`wip/p9-6-starters`), NOT `$CLI`. Another agent (P9-3b) is editing the main kit worktree and `$CLI` at the same time
(docs Flows pages, `dashcn add flow:<id>`, flow polish under `lib/src/flows/**`): do not touch those worktrees, and
in your worktrees do not edit `lib/src/flows/**`, `docs/lib/pages/**`, `docs/lib/routing/**`, or the CLI `add` command
(the orchestrator merges both branches afterwards; keep your edits additive so the merge is clean).

Read first: `$APP/lib/src/flows/*` (entry widgets + constructor params), `$APP/lib/src/blocks/{dashboard-01,
pricing-01,sidebar-01,login-01}`, the manifest generator `$APP/tool/registry/gen_registry_manifest.dart`,
`tool/gen_exports.dart`, `tool/rearch/check_layers.dart`, `$APP/lib/src/theme/interop/` (P9-4 import), and in the CLI
`bin/dashcn.dart`, the command wiring, `init` (package/copy modes), the installer + manifest closure, and
`theme import`.

## Kit: starter definitions (data, not Dart API)
- `lib/src/starters/<id>/starter.json` + `templates/*.dart.tmpl` (main.dart, app/router, shell, home, a smoke test)
  + `README.md`. Type `starter` in the registry manifest (screens/routes → flows/blocks, `dependencies`,
  `themePreset`, `platforms`). Not exported from any library; excluded from previews/blocks/scorecards generators
  and from `check_layers` Dart rules (templates are not compiled in the package) — but make sure `dart analyze` of
  the package does not pick up `.tmpl` files and that `flutter pub publish --dry-run` stays clean.
- v1.0 starters:
  - `saas`: auth-01 → onboarding-01 → shell (sidebar on wide / bottom tab bar on narrow) with dashboard-01,
    pricing-01, settings-01.
  - `chat`: auth-01 → chat-01, settings-01 (tab bar).
  - `shop`: auth-01 → product grid (built in the starter's templates from components — card, image, badge, button;
    NO new kit block) → checkout-01, settings-01.
- Starters wire flows with real callbacks into the app's own small state (in-memory repository class in the
  generated app, clearly marked "replace with your backend") — never fake backends inside the kit.

## CLI: `dashcn create`
`dashcn create <starter> <name> [--theme <preset|file.css>] [--mode package|copy] [--platforms ios,android,web,macos,
windows,linux] [--org com.example] [--force]` and `dashcn create --list`.
- Runs `flutter create --empty --org … --platforms … <name>`, then: package mode → `flutter pub add dashcn` (from the
  kit path when `DASHCN_KIT_ROOT` is set, for tests); copy mode → `dashcn init --mode copy` + install the closure of
  the starter's flows/blocks/components into `lib/ui/dashcn/` (reuse the installer — do not reimplement).
- Renders templates (simple `{{var}}` substitution: app name, package name, imports per mode, theme), writes
  `lib/**` + `test/smoke_test.dart`, `--theme file.css` uses the P9-4 importer, preset names validated against the
  43 presets. `dart format` the result; print next steps.
- Guards: refuses a non-empty target dir unless `--force`; unknown starter/preset → clear error + exit code;
  `--dry-run` prints the plan without writing.
- Tests: unit (template rendering, arg validation, guards) + e2e per starter × mode in a temp dir with
  `DASHCN_KIT_ROOT=$KIT`: create → `flutter analyze` 0 issues → `flutter test` (the generated smoke test walks the
  main routes: sign in → home → each tab/page). Mark e2e skipped (with reason) only when flutter is not on PATH.
- Docs: CLI `doc/user/complete-guide.md` section, CHANGELOG 1.0.0 entry, README command list.

## Gates
Kit (`$APP`): `bash ../rearch/qa_gate.sh`, every generator `--check`, `dart run tool/check_names.dart` (0),
`dart format --set-exit-if-changed .`, `flutter pub publish --dry-run` (no new warnings vs. before; note the count).
Docs (`$DOCS`): `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`, both `--check`, `flutter analyze`,
`flutter test test tool`. CLI (`$ROOT/dashcn-cli-b`): `dart analyze`, `DASHCN_KIT_ROOT=$KIT dart test`,
`dart format --set-exit-if-changed .`, `bash tool/sync_interop.sh --check`. Do not commit; the orchestrator commits.

## Report
`$KIT/rearch/reports/P9-6.md` (per repo changes, starters × modes e2e results with timings, open follow-ups) ending
with `## RESULT` and `status: done` or `status: blocked`.
