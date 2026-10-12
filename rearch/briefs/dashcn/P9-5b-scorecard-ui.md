# P9-5b — Trust scorecards on the docs site

Prerequisite: P9-5a accepted (`$APP/lib/src/manifests/scorecards.json`, `$APP/tool/gen_scorecards.dart`). Read
`$KIT/rearch/reports/P9-5a.md`, the JSON shape, `$DOCS/tool/gen_docs_data.dart`, `$DOCS/lib/pages/component_page.dart`
(read-only — do not edit; P9-Z wires it). You work in the MAIN kit worktree; another agent works in a separate
worktree.

## Rules
Honest presentation only. `null` = "Not measured" (never shown as pass). Frame time is labelled
"Frame build time — test environment (relative)" with a tooltip explaining it is not device performance. Tap-target
results are labelled "Mobile tap-target guideline (44/48 px)" — informational for desktop-sized controls, not hidden.

## Tasks
1. Generator: extend `gen_docs_data.dart` to emit `docs/lib/generated/docs_scorecards.dart` from scorecards.json
   (`--check` keeps working; deterministic; include `generatedAt` + short commit for the footer).
2. Widget `docs/lib/widgets/scorecard/scorecard_card.dart`: four sections (Accessibility, Right-to-left, Frame time,
   Tests) with pass/fail/not-measured badges, the failing guideline message in an expandable detail, the
   "measured on <date> at <commit>" footer and a "How we measure" link. Light/dark, theme-dependent spacing, kit
   components only. Integration point `ScorecardCard(componentId: ...)` documented in the report (P9-Z places it).
3. Page "How we measure" (`docs/lib/pages/scorecards_page.dart` + route): what each metric is, how it is produced
   (`dart run tool/gen_scorecards.dart`), its limits (test font, test environment timing, guideline thresholds), and an
   overview table of all components with their badges, sortable by failures. Add the route via the existing router
   with a nav entry under Docs.
4. Tests `docs/test/scorecard/`: card renders pass/fail/null for a fixture; detail expands; page table renders all
   83 rows; `gen_docs_data --check` clean. Screenshot captures (light/dark card + page) to
   `../rearch/screenshots/p9-5b/` relative to the docs package (do not open them).

## Owns
`$DOCS/tool/gen_docs_data.dart` (+ its `src/` helpers for this output), `$DOCS/lib/generated/docs_scorecards.dart`,
`$DOCS/lib/widgets/scorecard/**`, `$DOCS/lib/pages/scorecards_page.dart`, router/nav entries for that one route,
`$DOCS/test/scorecard/**`.

## Gates
Docs: `dart format --set-exit-if-changed lib test tool`, `flutter analyze`, `flutter test`, `gen_docs_data --check`,
`sync_registry --check`, `flutter build web --release`.

## Report
`$KIT/rearch/reports/P9-5b.md`
