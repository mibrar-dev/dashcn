# P8-5 — release engineering (CI, changelogs, publishing workflow — configured, NOT run)

Read: `DASHCN_PACKAGE_PLAN.md` P8-5, `DASHCN_FEATURES_PLAN.md` §0 (version 1.0.0 everywhere), the existing workflows
in `$KIT/.github/workflows/` and `$CLI/.github/workflows/` (if any), `$KIT/dashcn/CHANGELOG.md`, `$CLI/CHANGELOG.md`,
`$KIT/rearch/plans/DASHCN_PROGRESS.md` (release prerequisites noted there).

Hard limits: do NOT publish anything, do NOT create tags/releases, do NOT push, do NOT call GitHub/pub.dev APIs that
change state. Workflows are written and validated locally only.

## Tasks
1. **Kit CI** `$KIT/.github/workflows/ci.yml` (on pull_request + push to main and refactor/**): Flutter stable pinned
   to 3.47.x; jobs: `kit` (working-directory `dashcn`: pub get, `dart format --set-exit-if-changed`, `flutter analyze`,
   `flutter test test/registry test/rearch test/tool`, `gen_exports --check`, `check_names`, manifest/previews/blocks
   generators `--check`, `dart pub publish --dry-run`), `docs` (format, analyze, test, `gen_docs_data --check`,
   `sync_registry.sh --check` (install rsync), `flutter build web --release`). Cache pub. Replace/merge the existing
   `registry-verify.yml` so nothing runs twice; keep `docs-deploy.yml` working (base href stays `/shadcn_flutter_kit/`
   until the repo rename) and make it build from `main` only.
2. **Kit publishing** `$KIT/.github/workflows/publish.yml`: on tag `v[0-9]+.[0-9]+.[0-9]+*`, uses
   `dart-lang/setup-dart/.github/workflows/publish.yml@v1` (pub.dev automated publishing via GitHub OIDC; no secrets),
   `working-directory: dashcn`, environment `pub.dev`. Add a job that fails if the tag does not equal
   `v<pubspec version>`.
3. **CLI CI + publishing** in `$CLI/.github/workflows/`: ci.yml (format, analyze, `dart test`, e2e suites with the kit
   checked out next to it via `actions/checkout` of `mibrar-dev/shadcn_flutter_kit` at a ref given by an input/default
   `refactor/dashcn`, `DASHCN_KIT_ROOT` set, `tool/sync_interop.sh --check`, `rename_cli --check`, publish dry-run) and
   publish.yml (same OIDC pattern, tag = `v<version>`).
4. **Changelogs** (Keep a Changelog 1.1.0): `dashcn/CHANGELOG.md` and `$CLI/CHANGELOG.md` → `## [1.0.0] - Unreleased`
   describing the first release (features, not a rename history: dashcn is published from scratch).
5. **Release docs** `$KIT/RELEASING.md` (+ short `$CLI/RELEASING.md` pointing to it): semver policy (1.0.0 = stable API,
   breaking changes need 2.0.0, deprecation window), the one-time pub.dev setup Ibrar must do by hand (create the
   package by first manual publish or enable automated publishing for `dashcn`/`dashcn_cli` with the repo + tag
   pattern + environment), release order: tag the kit `v1.0.0` FIRST (the CLI's default registry pins
   `mibrar-dev/shadcn_flutter_kit@v<cli version>/dashcn/lib/src`), then the CLI; GitHub repo-rename checklist
   (update CLI default registry host, kit allow-lists, Pages base href, `kDocsBasePath`, pubspec URLs).
6. **Validate**: `actionlint` on every workflow (download the release binary from GitHub into
   `$KIT/rearch/logs/bin/`; do not install system-wide) → 0 findings; YAML parses.

## Owns
`$KIT/.github/**`, `$KIT/dashcn/CHANGELOG.md`, `$KIT/RELEASING.md`, `$CLI/.github/**`, `$CLI/CHANGELOG.md`,
`$CLI/RELEASING.md`. Everything else read-only. Another agent (P9-5a) works in `$KIT/dashcn` test/tool/manifests at
the same time — do not run the kit's full test suite; CI correctness is checked with actionlint + by reading.

## Report
`$KIT/rearch/reports/P8-5.md`
