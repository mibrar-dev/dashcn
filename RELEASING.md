# Releasing dashcn

How the `dashcn` package (and the `dashcn_cli` companion) get to pub.dev.
The CLI side is one paragraph in `dashcn-cli/RELEASING.md`; everything else
lives here.

## Semver policy

- The first release is `0.1.0`, published from scratch (no upgrade path from
  the old code-copy layout or the discontinued `flutter_shadcn_cli`).
- While on `0.x`, a minor bump (`0.2.0`) may break the public API and a patch
  bump (`0.1.1`) never does. Breaking changes are listed in the CHANGELOG.
- `1.0.0` follows an API review once the plain names (`Theme`, `ThemeData`,
  `DashcnApp`, …) have been used in real apps. From then on breaking changes
  need a new major version.
- Deprecations: a deprecated API stays for at least one release with a
  documented migration path before it is removed.

## One-time pub.dev setup (Ibrar, by hand)

Automated publishing uses GitHub OIDC — no secrets. For each package, open
its pub.dev admin page and add an "Automated publishing" entry:

| Package | Repo | Workflow | Tag pattern | Environment |
|---|---|---|---|---|
| `dashcn` | `mibrar-dev/dashcn` (or `mibrar-dev/dashcn` after the repo rename) | `publish.yml` | `v{{version}}` | `pub.dev` |
| `dashcn_cli` | `mibrar-dev/dashcn_cli` (or the renamed repo) | `publish.yml` | `v{{version}}` | `pub.dev` |

The `publish.yml` workflows in this repo already pass `environment: pub.dev`,
so create a `pub.dev` environment in each repo's settings (required reviewers
recommended — anyone with push access could otherwise publish by pushing a
tag). If the package has never been published, the first publish can be done
from a checkout (`dart pub publish`) to create the listing, then automation
takes over.

## Release order

1. **Kit first.** Tag the kit `v0.1.0`: the CLI's default registry pins
   `mibrar-dev/dashcn@v<cli version>/dashcn/lib/src`, so a
   published CLI only works with defaults when the matching kit tag (with
   the `dashcn/` layout) exists.
2. Verify `dashcn` on pub.dev, then tag the CLI `v0.1.0` in its repo.

## How to cut a release

1. Set the CHANGELOG entry date (`## [0.1.0] - 2026-…`) in
   `dashcn/CHANGELOG.md` (and `CHANGELOG.md` in the CLI repo).
2. Run every gate: kit `rearch/qa_gate.sh` plus all `--check` generators,
   `check_names`, docs format/analyze/test plus `gen_docs_data --check`,
   `sync_registry.sh --check` and `flutter build web --release`, CLI
   format/analyze/unit/e2e plus `rename_cli --check` and
   `sync_interop.sh --check`. CI runs the same on the tag push, but a red
   tag still sends publish notifications — keep tags green.
3. `git tag v0.1.0` in the kit repo, push the tag. `publish.yml` first fails
   unless the tag equals `v<pubspec version>`, then publishes via OIDC.
4. Repeat in the CLI repo once the kit release is live on pub.dev.
5. Write GitHub Release notes from the CHANGELOG entry.

Never publish from a laptop except for the one-time listing creation above;
never push tags for versions that are not in the CHANGELOG.

## GitHub repo-rename checklist

Until Ibrar renames the repos, the old names stay allow-listed
(`dashcn/tool/check_names_allow.txt`, CLI `tool/rename_cli.dart`). When the
rename happens, update every reference in one pass:

- [ ] CLI default registry host:
      `dashcn-cli/lib/src/application/services/registry_source_resolver.dart`
      (raw.githubusercontent URL + versioned doc comment).
- [ ] Kit allow-list `dashcn/tool/check_names_allow.txt` (remove the old
      repo-name entries) and re-run `tool/check_names.dart`.
- [ ] Pages base href: `baseHref` in `.github/workflows/docs-deploy.yml`.
- [ ] `kDocsBasePath` in `docs/lib/routing/docs_router.dart` (and its tests).
- [ ] pubspec URLs: `homepage`/`repository`/`issue_tracker` in
      `dashcn/pubspec.yaml` and `repository`/`homepage` in the CLI
      `pubspec.yaml`.
- [ ] Docs footer `kDocsRepoUrl` in `docs/lib/widgets/docs_footer.dart`.
- [ ] Kit `README.md` badges and links (repo, Pages site, Actions).
- [ ] Skills install URLs in `dashcn/skills/*/INSTALLATION.md`.
- [ ] `themes.schema.json` `$id` (old Pages host).
- [ ] Docs app config/README/pubspec references to the old kit repo.
- [ ] pub.dev automated-publishing entries (repo + tag pattern) for both
      packages, since the repo field changes.
