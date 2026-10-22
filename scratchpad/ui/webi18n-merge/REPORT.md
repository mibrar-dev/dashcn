# REPORT: merge `origin/main` into `feat/website-i18n-header` (`dashcn-w-webi18n`)

## Merge

- `git fetch origin main; git merge origin/main` in worktree `dashcn-w-webi18n`.
- Only `docs/lib/pages/component_page.dart` conflicted (three hunks). All other
  overlapping files (`panel_body.dart`, `playground_panel.dart`,
  `docs_article.dart`) auto-merged cleanly and already kept both sides
  (grouped controls + `inlineControls` from main, `docsChrome` + header
  insets from the i18n branch).

## Resolution (`component_page.dart`)

Kept main's PR 56 playground layout:

- `openPlayground()` / `closePlayground()` (clear `p.*` so no cross-component
  leak), `playgroundActive` (`_playgroundOpen || query` + `hasPlayground`),
  `hideToc: playgroundActive`, single live canvas (`if (!playgroundActive)`
  `ComponentPreviewCard`), `PlaygroundScope`, `panelContent()` (live canvas +
  grouped controls + Reset/Copy + live code), desktop
  `Row[Expanded(article), 380px panel]` + phone (`<1024`) bottom sheet
  (85% height, rounded top), `PlaygroundPanel(..., reportUrl: false,
  inlineControls: true)`.

Kept this branch's locale-aware labels (locale from `DocsRouterScope`):

- Playground open button: `onPressed: openPlayground` +
  `Text(docsChrome(locale, 'cmpPlayground'))`.
- Panel header title: `docsChrome(locale, 'cmpPlayground')`.
- Panel close: `onPressed: closePlayground` +
  `Text(docsChrome(locale, 'close'))`.
- Preserved auto-merged i18n elsewhere in the file: scorecard dialogs
  (`close`), `docsFileCount`, `cmpWip` / `cmpWipNote`, `cmpTrust`.

Kept the branch's floating-header inset:

- `final double panelTop = (contentWidth >= 1024 ? 64.0 : 56.0) + 12;`
- `panelContent()` header padding is
  `EdgeInsets.fromLTRB(theme.spacing.lg, panelTop, theme.spacing.md,
  theme.spacing.sm)` (main's theme-spacing horizontals, branch's top inset).

## Other chrome (main plain English → `docsChrome`)

- `panel_body.dart` Copy code: new key `pgCopyCode` (`Copy code` in en),
  `CopyButton(label: copyLabel, tooltip: copyLabel)` with
  `copyLabel = docsChrome(locale, 'pgCopyCode')`. `pgReset` / `pgControls` /
  `pgEdit` / `pgDone` already localized and preserved by the auto-merge.
- Group titles: new keys `pgGroupAppearance` / `pgGroupSize` / `pgGroupState` /
  `pgGroupContent`. Kept `playgroundGroupTitle` (English fallback) and added
  `playgroundGroupTitleFor(Locale, groupId)` using `docsChrome`; both
  `PlaygroundControlsList` (`panel_body.dart`) and
  `PlaygroundGroupedControlsList` (`groups.dart`) now resolve titles from
  `DocsRouterScope` locale.
- `docs_strings.dart`: `kDocsChromeKeys` 95 → 100; added the 5 keys to every
  one of the 42 locale tables (`en de ar fr es it pt pt_BR nl ja ko zh
  zh_Hans zh_Hant vi ru uk bg pl cs sk ro el hu da sv nb fi tr fa ur he ps id
  ms hi bn mr ta te fil th`).

## Test-only fix for the floating header

- `test/component_page_playground_test.dart` (new from main) used plain
  `tester.ensureVisible`, which parks the target under the floating header
  (64/56 px) so taps hit the bar. Switched `_openPlayground` and `_pickOption`
  to `ensureVisibleBelowHeader` (existing harness helper). No production code
  changed for this; `panel_figma_test` (direct panel, no shell) needed no
  change.

## Gates

- `dart format --output=none --set-exit-if-changed lib test tool` (docs): clean.
- `dart analyze` (docs): No issues found.
- `flutter test test/component_page_test.dart test/playground`: all passed
  (291).
- `flutter test test/website_i18n_test.dart`: all passed (8/8, including
  `every chrome key exists in every locale table` with the 5 new keys).
- `flutter test test/component_page_playground_test.dart
  test/playground/ui/panel_figma_test.dart`: all passed (4 + 3).
- `dart run tool/gen_docs_data.dart --check`: up to date (18 files).
- `bash tool/sync_registry.sh --check`: mirror is up to date.

## Push

- Committed the merge on `feat/website-i18n-header` with trailer
  `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`, pushed (no
  force-push, no rebase). Branch not merged into `main`.
