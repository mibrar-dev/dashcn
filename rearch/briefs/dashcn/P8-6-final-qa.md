# P8-6 — Final QA + release candidate (no publishing, no tags)

Spec: `DASHCN_PACKAGE_PLAN.md` §P8-6, `RELEASING.md`, `DASHCN_FEATURES_PLAN.md` acceptance lines. Everything (P8-1…P8-5,
P9-1…P9-6, P9-Z, P9-Z2, KIT-FIX-1) is merged. You work in a SECONDARY kit worktree (`$KIT`, branch `wip/p8-6-rc`) and
a SECONDARY CLI worktree **`$ROOT/dashcn-cli-b`** (branch `wip/p8-6-rc`), NOT `$CLI`. Both start at the merged
`refactor/dashcn`. You FIND and FIX release blockers; anything bigger than a contained fix goes to the report as a
follow-up with evidence. NEVER publish, tag, push or create releases (`pub publish` only with `--dry-run`).

Temp apps go under `$KIT/rearch/logs/p8-6/` (gitignored); delete them at the end.

## 1. Fresh-app journeys (record every command + result in the report)
Use `DASHCN_KIT_ROOT=$KIT` so the CLI resolves the local kit, and a local path dependency for the package.
1. Package mode: `flutter create --empty app_pkg` → `flutter pub add dashcn --path $APP` → write a `main.dart` using
   `DashcnApp` + a few components (button, input, dialog, select), a block (`login-01` via
   `package:dashcn/blocks/...`) and a flow (`package:dashcn/flows/auth_01.dart`) → `flutter analyze` (0) →
   `flutter test` with a widget test pumping it → `flutter build web` (and `flutter build linux` if the toolchain is
   present; otherwise note it).
2. Copy mode: `dashcn init --mode copy` → `dashcn add button dialog select` → `dashcn add login-01` →
   `dashcn add flow:auth-01` → analyze/test → `dashcn eject` round-trip on a package-mode app
   (`dashcn add --package button` then `dashcn eject button`) → analyze.
3. Starters: `dashcn create saas|chat|shop` in both modes with `--dry-run` first, then for real → analyze + the
   generated smoke test (spot-check that the e2e suite covers these; do not re-run more than one full matrix).
4. Theme bridge: `dashcn theme import` a tweakcn CSS sample into a copy-mode app, then `theme export --format css` and
   diff it semantically (same tokens).
5. `dashcn doctor`, `list`, `search otp`, `info flow:auth-01`, `create --list`: clean output, exit 0.

## 2. Package quality
- `flutter pub publish --dry-run` in `$APP` and `dart pub publish --dry-run` in `$ROOT/dashcn-cli-b`: 0 warnings
  (fix `.pubignore`/`files` issues; the old note "13 checked-in files ignored" must be gone or explained).
- Run `pana` if it can be installed (`dart pub global activate pana`); record the score breakdown for both packages
  and fix cheap point losses (docs on public API, example, platforms, description length, dependency constraints).
- Versions: `1.0.0` in both pubspecs, CHANGELOG top entries, CLI `--version`, README badges/snippets; the CLI's
  default registry pin (`v1.0.0`) matches `RELEASING.md`'s release order.
- Public API review: list the libraries exported by the package (`lib/*.dart`), spot-check that no `src/`-only types
  leak through public signatures (`dart doc --dry-run` or the analyzer `public_member_api_docs`), and that no
  "shadcn" names remain outside the allow-list (`check_names` 0).

## 3. Docs site release check
`flutter build web --release --base-href /shadcn_flutter_kit/` in `$DOCS`, serve `build/web`, and with Playwright
(Chromium at `/opt/pw-browsers/chromium`) visit: `/`, `/docs/installation`, `/docs/components/button`,
`/docs/flows/auth-01`, `/docs/starters/saas`, `/docs/scorecards`, `/themes`, a 404 — no console errors, first frame
painted, with locales `en-US` and `C`. Record console output summaries.

## 4. Gates (both repos, on your final tree)
Kit (`$APP`): `bash ../rearch/qa_gate.sh`, every generator `--check`, `check_names` (0), `dart format
--set-exit-if-changed .`. Docs: `sync_registry`/`gen_docs_data` + both `--check`, `flutter analyze`, `flutter test
test tool` (background + log), `dart format --set-exit-if-changed .`, `flutter build web`. CLI
(`$ROOT/dashcn-cli-b`): `dart analyze`, `dart format --set-exit-if-changed .`, `bash tool/sync_interop.sh --check`,
`DASHCN_KIT_ROOT=$KIT dart test` (unit + e2e; background + log). Do not commit; the orchestrator commits.

## Report
`$KIT/rearch/reports/P8-6.md`: journeys table (step → result), package quality (dry-run, pana scores), docs release
check, fixes made (file → why), release-blockers left (none, ideally), and a short "Ready to release" checklist that
mirrors `RELEASING.md` (what Ibrar must do by hand: pub.dev automated publishing, environments, tags, repo rename
decision). End with `## RESULT` and `status: done` or `status: blocked`.
