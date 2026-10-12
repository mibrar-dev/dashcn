# P9-3b — Flows on the docs site + `dashcn add flow:<id>` + flow polish

Spec: `DASHCN_FEATURES_PLAN.md` §P9-3 (binding) and the P9-3a report `$KIT/rearch/reports/P9-3a.md`. You work in the
MAIN kit worktree (`$KIT`, branch `refactor/dashcn`) AND the CLI worktree (`$CLI`, branch
`refactor/dashcn`). Another agent (KIT-FIX-1) edits `$APP/lib/src/primitives/form_core`, theme colours and component
semantics in a secondary worktree: do NOT touch those; keep kit edits to `lib/src/flows/**`.

Read first: `$APP/lib/src/flows/*` (README, meta.json, flow.dart, screens), `$DOCS/lib/pages/blocks_pages.dart`
(closest docs pattern), `$DOCS/lib/widgets/device_frame/` (P9-1), `$DOCS/tool/gen_docs_data.dart` +
`tool/sync_registry.sh`, `$DOCS/lib/routing/docs_router.dart` + `docs_nav.dart` (you are the named batch allowed to
add nav entries this wave), and in the CLI the block install path (`lib/src/registry/manifest/registry_manifest.dart`,
`lib/src/application/services/manifest_closure.dart`, `installer/dry_run_plan.dart`, `add` command, package mode).

## 1. Docs: "Flows" section
- Nav section "Flows" (after Blocks) + index page `/docs/flows` with one card per flow (name, one-line summary, screen
  count, small phone-frame thumbnail of the first screen).
- Flow page `/docs/flows/<id>`: runs the real flow inside the P9-1 iPhone frame by default (frame bar lets the reader
  switch device / All / light-dark / rotate as on component pages), a **screen map** strip (thumbnail per screen; tap
  jumps the live flow to that screen — via the flow's own navigator/initial-route API if it has one; if it does not,
  add a small public `initialScreen` parameter in the kit flow with tests), install tabs (Package | Own the code, reuse
  `docs/lib/widgets/install_commands.dart` + `ComponentInstallBlock` pattern; commands `flutter pub add dashcn` +
  `import 'package:dashcn/flows/<id>.dart';` / `dashcn add flow:<id>`), and code per screen (from the mirrored source,
  generated like blocks — no hand-copied code).
- Demo data and callbacks live in docs only (e.g. sign-in shows a toast), never inside the kit.
- Generated data goes through the existing generators (`gen_docs_data`, `sync_registry` mirror incl. `flows/`) with
  `--check` support; add tests in `$DOCS/test/flows/` (route parse/round-trip, index lists every flow from the
  manifest — derive counts, never hard-code; screen-map tap changes the visible screen; install tabs).
- Captures: `test/flows/capture_test.dart` → `rearch/screenshots/p9-3b/` (index + each flow page, light + dark, at
  1280×900 and 390×844). Wrap like the real surface; the `RepaintBoundary` must wrap the background (see
  `test/p8_4/capture_test.dart`).

## 2. CLI: `dashcn add flow:<id>`
- Copy mode: installs the flow's files under `lib/ui/dashcn/flows/<id>/` + the closure of its components/blocks
  dependencies (reuse the block closure code), records it in `dashcn.lock`, `--dry-run` lists files.
- Package mode: no copy; prints/adds the `import 'package:dashcn/flows/<id>.dart';` hint like blocks/components.
- `dashcn list` / `search` / `info` show flows (type `flow`). `dashcn eject flow:<id>` works if eject supports blocks;
  otherwise report it as follow-up.
- Tests: unit + e2e against the kit (`DASHCN_KIT_ROOT=$KIT`), incl. a fresh temp app where `flutter analyze` passes
  after `add flow:auth-01` in copy mode. Update the CLI docs (`doc/user/complete-guide.md`), CHANGELOG (1.0.0 entry),
  and regenerate the docs CLI reference snapshot (`$DOCS/tool/cli_snapshot.txt` + `gen_docs_data`) if help text
  changed.

## 3. Flow polish (kit, `lib/src/flows/**` only)
- auth-01 sign-in: "No account yet?Create one" — missing space/gap between the text and the link (check sign-up's
  "Already have an account?" too).
- settings-01: the home screen is vertically centred; it must be top-aligned like a real settings list.
- settings-01: toggle rows are cramped — use the list-row density/padding the other rows use (theme-dependent spacing).
- Re-run the flows' tests and regenerate the P9-3a screenshots; compare before/after in the report.

## Gates
Kit (`$APP`): `bash ../rearch/qa_gate.sh`, every generator `--check`, `dart run tool/check_names.dart` (0),
`dart format --set-exit-if-changed .`. Docs: `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`, then both
`--check`, `flutter analyze`, `flutter test test tool`, `dart format --set-exit-if-changed .`, `flutter build web`.
CLI: `dart analyze`, `DASHCN_KIT_ROOT=$KIT dart test`, `dart format --set-exit-if-changed .`,
`bash tool/sync_interop.sh --check`. Do not commit; the orchestrator commits.

## Report
`$KIT/rearch/reports/P9-3b.md` (what changed per repo, test counts, screenshots list, open follow-ups) ending with
`## RESULT` and `status: done` or `status: blocked`.
