# New session prompt — dashcn package + plain names (branch `refactor/dashcn`)

Copy everything below the line into a new Claude Code session started in
`/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/`.

---

You are the **orchestrator and QA reviewer** for turning the Flutter UI kit into the **`dashcn`** package with
plain public names. You plan, write briefs, delegate the heavy work to OpenCode sub-agents (never Claude sub-agents),
QA every result yourself, and commit + push after each accepted step.

## Branch + worktree (read carefully)
- Kit repo: `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit` (remote
  `mibrar-dev/shadcn_flutter_kit`). CLI repo: `/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_cli`
  (remote `mibrar-dev/flutter_shadcn_cli`).
- Another session keeps working on **`refactor/rearchitecture`** in those two folders — do NOT edit, checkout, commit
  or run builds in them.
- Create your own branch + worktrees:
  ```
  cd /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit
  git fetch origin
  git worktree add -b refactor/dashcn ../dashcn-kit origin/refactor/rearchitecture
  cd ../shadcn_flutter_cli && git fetch origin
  git worktree add -b refactor/dashcn ../dashcn-cli origin/refactor/rearchitecture
  ```
  Work ONLY in `../dashcn-kit` and `../dashcn-cli`; push `refactor/dashcn` in both repos after each accepted step.
- **Never merge `refactor/dashcn` into `refactor/rearchitecture` or `main`**, open no PR, publish nothing, rename no
  GitHub repo unless Ibrar asks. To pick up later fixes from the other session, merge one-way
  `origin/refactor/rearchitecture` → `refactor/dashcn` (before the big rename if possible; after it, re-run the rename
  codemod on the incoming changes).
- Read first: `rearch/plans/DASHCN_PACKAGE_PLAN.md` (the approved plan — binding), `rearch/PROGRESS.md`,
  `rearch/reports/QA_LOG.md` (last sections), `REARCHITECTURE_PLAN.md`, the registry under
  `flutter_shadcn_kit/lib/registry/`, the docs app `docs/`, and the CLI.

## Decisions (Ibrar)
- Package name **`dashcn`** (free on pub.dev, as are `dashcn_cli`, `dashcn_ui`). CLI package `dashcn_cli`, executable
  `dashcn`.
- **No "shadcn" anywhere** — public API, file/folder names, CLI, lock/config files, docs site, code samples. Plain names;
  where a plain name clashes with `package:flutter/widgets.dart`, use a descriptive name, never a prefix.
- Clean break: no aliases, no deprecated typedefs, no migrate command.
- Widgets-only design system (no Material/Cupertino), like Material/Cupertino once they are decoupled into packages.
- Both distribution modes from one source: the **package** (`flutter pub add dashcn`) and **own-the-code** copy-paste
  (`dashcn add <id>`), plus new **`dashcn eject <id>`** (package-imported component → owned source in the app).

## Rename map (public API) — from the plan
| Today | New |
|---|---|
| `ShadcnApp` | `App` (Ibrar to confirm vs `DesignApp` — ask before P8-2) |
| `ShadcnTheme`, `ShadcnThemeData`, `ShadcnThemeDataTween` | `Theme`, `ThemeData`, `ThemeDataTween` |
| `ShadcnColors`, `ShadcnFonts`, `ShadcnTokens` | `ThemeColors`, `ThemeFonts`, `DesignTokens` |
| `ShadcnForm`, `ShadcnFormField` | `FormScope`, `FormItem` |
| `ShadcnImage` | `Picture` |
| `ShadcnTable`, `…Row`, `…Cell`, `…Header`, `…Footer`, `…State` | `TableView`, `TableViewRow`, `TableViewCell`, `TableViewHeader`, `TableViewFooter`, `TableViewState` |
| `ShadcnRadioGroup`, `ShadcnRadioGroupController` | `RadioSet`, `RadioSetController` |
| `ShadcnPage`, `ShadcnPageRoute`, `ShadcnPageTransition` | `AppPage`, `AppPageRoute`, `AppPageTransition` |
| `ShadcnDialogRoute`, `ShadcnDrawerRoute` | `DialogRoute`, `DrawerRoute` |
| `ShadcnLayer` | `AppLayer` |
| `ShadcnLocalizations` (+ ~50 language/part classes + delegate) | `ComponentLocalizations` (+ `ComponentLocalizationsAr` …, `ComponentLocalizationsDelegate`) |
| `ShadcnSelectionControls`, `ShadcnTextSelectionToolbar` | `SelectionControls`, `SelectionToolbar` |
| `ShadcnUI` | remove (barrel replaces it) |
| `showShadcnDialog/Popup/Menu/Dropdown/ContextMenu` | `showDialog`, `showPopup`, `showMenu`, `showDropdown`, `showContextMenu` |
Re-verify the inventory from the code (grep/analyzer) — the table may be incomplete; also rename internal private
`_Shadcn…` names and `shadcn…` identifiers/strings.
Mixing with Material (`Theme`, `Card`, `Dialog`, `Switch`, `showDialog`…) is documented: `import … as ui` / `hide`.

## Non-API renames
`lib/registry/` → `lib/src/` (same layers: foundation, theme, primitives, components, blocks); copy-paste install dir
`lib/ui/shadcn/` → `lib/ui/dashcn/` (configurable in `dashcn.yaml`); lock `dashcn.lock`, config `dashcn.yaml`/`.dashcn/`;
manifest keeps its schema (rename shadcn-named fields); preset JSON + generated `app_theme.dart` symbols; docs site
brand/title/samples/CLI reference; the `flutter_shadcn_kit` folder/package → `dashcn` (keep git history with `git mv`).

## Phases (each = briefs → OpenCode agents → your QA → commit → push)
- **P8-1 Package skeleton** — `pubspec.yaml` name `dashcn`, version `0.1.0`; `lib/dashcn.dart` barrel + per-layer
  (`foundation.dart`, `theme.dart`, `primitives.dart`) + per-component (`lib/components/<id>.dart`) + blocks libraries
  generated by `tool/gen_exports.dart --check`; move to `lib/src/`; `example/` app; lints; `dart pub publish --dry-run`
  clean (README, CHANGELOG, LICENSE, example, platforms).
- **P8-2 Plain-name rename** — analyzer-driven codemod `tool/rename_api.dart` from the table (declarations + every
  reference across registry, blocks, previews, tests, docs, CLI templates, READMEs, meta.json `api`, manifest);
  guardrail `tool/check_names.dart` (no `shadcn`, no public clash with widgets.dart) wired into `rearch/qa_gate.sh`.
  Never hand-rename.
- **P8-3 CLI** — `dashcn_cli`/`dashcn`; install dir/lock/config renames; `eject` (rewrites app imports from the
  package to the owned copy); `add --package` (adds the pub dependency + import instead of copying); `init` asks copy vs
  package; unit + e2e tests for copy, package and eject.
- **P8-4 Docs** — depend on `dashcn` (path dep), regenerate data/snippets/API/CLI reference, brand strings, new pages
  "Package vs own the code" and "Using dashcn alongside Material", install tabs (`flutter pub add dashcn` / `dashcn add …`).
- **P8-5 Release engineering** — CHANGELOG (Keep a Changelog), semver policy (0.x may break; 1.0 after API review),
  GitHub Actions: analyze/test on PR; automated pub.dev publishing on `vX.Y.Z` tags via OIDC (configure, do not run);
  same for the CLI; docs GitHub Pages deploy.
- **P8-6 Final QA** — all gates in both repos; fresh-app tests: `flutter create` → path-dep `dashcn` → run; `dashcn init`
  → `add` → `eject`; `dart pub publish --dry-run` score review. Report to Ibrar.

## Agents (OpenCode, detached)
- Models: `opencode-go/muse-spark-1.3-contributor#xhigh` first; if "Insufficient account funds" / "Model unavailable"
  / "Endpoint is unavailable", fall back to `opencode-go/step-5-preview-free#high`, then
  `opencode-go/longcat-2.5-preview-free`. A session whose provider changed may fail with "reasoning … not issued to this
  caller" → start a FRESH session with a handoff brief (read the brief + report + git diff, continue).
- Launch detached so they survive your restarts:
  `perl -MPOSIX -e 'POSIX::setsid(); exec @ARGV' nohup rearch/run_agent.sh <model> <brief> <log>` (resume:
  `rearch/continue_agent.sh <session> <model> <prompt> <log>`); logs in `rearch/logs/`. Watch with a Monitor that
  reports only `exit=` lines / 25-min silence (agents print old log text — don't grep whole logs for errors).
- Briefs: explicit file ownership, gates, report path with `## RESULT`, "Do NOT open PNG images yourself" (models
  crash on images), "No git ops".
- QA yourself: run every gate, build the docs (`flutter build web --release`), serve it and LOOK at screenshots
  (agent-browser / built-in browser) — agents can't verify visuals. Commit only explicit paths (`git diff --cached`
  first; agents sometimes leave scratch files), message ending with
  `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.

## Gates (adapt paths after the move)
Kit: `rearch/qa_gate.sh` (format, analyze, registry tests, rearch tests, layers, owner, user-theme, banned),
generators `--check` (manifest, previews test, blocks test, exports), `check_names`. Docs: `dart format --output=none
--set-exit-if-changed lib test tool`, `flutter analyze`, `flutter test`, `dart run tool/gen_docs_data.dart --check`,
`bash tool/sync_registry.sh --check`, `flutter build web --release`. CLI: `dart format`, `dart analyze`, `dart test`,
`dart test -t e2e --run-skipped test/e2e/acceptance_test.dart`.

## Ask Ibrar before
`App` vs `DesignApp` (before P8-2), GitHub repo renames, publishing to pub.dev, PRs, merging anything into
`refactor/rearchitecture` or `main`, deleting user work. Keep a log in `rearch/plans/DASHCN_PROGRESS.md`.
