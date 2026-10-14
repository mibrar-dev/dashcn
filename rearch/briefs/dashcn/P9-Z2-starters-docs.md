# P9-Z2 — Starters on the docs site

Spec: `DASHCN_FEATURES_PLAN.md` §P9-6 and §P9-Z. You work in the MAIN kit worktree (`$KIT`, branch
`refactor/dashcn`); no CLI changes unless a help-text fix is needed (then `$CLI`). P9-6 (starters) and P9-Z
(component page, landing hero, search/nav) are merged — read the P9-6 and P9-Z reports in `$KIT/rearch/reports/`,
`$APP/lib/src/starters/*`, the CLI `create` command (`$CLI/lib/src/presentation/cli/commands/create_command.dart`)
and the docs flows pages (`$DOCS/lib/pages/flows_pages.dart`, closest pattern).

## Build
- Generator: `$DOCS/tool` scans `lib/src/starters/<id>/starter.json` + README into generated data
  (`docs_starters.dart`: id, name, description, flows, blocks, components, routes, platforms, theme preset,
  template file list) with `--check` support and generator tests. Mirror sync must include starters if the page shows
  template sources (show the rendered-template *file list*, not raw `.tmpl` text; link to the source on GitHub).
- Nav: "Starters" after Flows (header escalation like Flows if width needs it; sidebar group; palette group).
- `/docs/starters` index: one card per starter (name, summary, flows/blocks chips, platforms) with a phone-frame
  thumbnail of the starter's main shell — compose it from the starter's flows/blocks with docs demo data (no
  template rendering at runtime).
- `/docs/starters/<id>`: what you get (routes table → flow/block pages links), the command
  (`dashcn create <id> my_app` with `--mode package|copy`, `--theme <preset|file.css>`, `--platforms`, `--org`,
  `--dry-run`, `--force`) in Package | Own-the-code tabs reusing `install_commands.dart`, the package vs copy
  theme-file split (`lib/app_theme.dart` vs `lib/ui/dashcn/theme/app_theme.dart`, from the P9-6 report), the
  generated file tree, next steps (run, replace the in-memory repository with a backend).
- Search index: starters (id, name, description, flows) + the index page; test that "saas" finds the saas starter.
- Getting Started page: one short "Start from a template" paragraph linking `/docs/starters`.
- Tests in `$DOCS/test/starters/` (routes round-trip, index lists every starter from generated data — derive counts,
  page content, search) and captures `test/starters/capture_test.dart` → `rearch/screenshots/p9-z2/` (index + saas
  page, 1280×900 and 390×844, light/dark; `RepaintBoundary` wraps the background).

## Gates
Kit (`$APP`): every generator `--check`, `dart run tool/check_names.dart` (0), `dart format --set-exit-if-changed .`.
Docs (`$DOCS`): `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`, both `--check`, `flutter analyze`,
`flutter test test tool` (run it in the background into a log under `$KIT/rearch/logs/` and poll; it takes ~9 min),
`dart format --set-exit-if-changed .`, `flutter build web`. Do not commit; the orchestrator commits.

## Report
`$KIT/rearch/reports/P9-Z2.md` ending with `## RESULT` and `status: done` or `status: blocked`.
