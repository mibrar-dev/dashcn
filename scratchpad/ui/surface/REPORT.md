# Surface tokens audit: report

Branch: `feat/surface-tokens-audit`. Worktree:
`/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/dashcn-w-surface`.
Reference: `dashcn/lib/src/components/navigation_bar/navigation_bar.dart`
(`_surface`) via `dashcn/lib/src/primitives/surface.dart`.
Note: `scratchpad/ui/design/DESIGN.md` does not exist in this worktree; the
audit proceeds from the task rule text plus the `navigation_bar` reference.

## Audit counts

- Fixed: 6 component files + the docs header = 7 files (see table).
- Reviewed, no change (delegates to the primitive or not a box-surface
  paint): 13 component files / 17 sites (details in `AUDIT.md`).
- Blocks page-background fills allow-listed (app background stays opaque):
  20 files. Flows page-background fills allow-listed: 11 files. Starters:
  clean (no hits).
- Full site list with file, token, and fix/reason: `scratchpad/ui/surface/AUDIT.md`.

## Each file changed

Library (paint through `surfaceColor` + `GlassSurface`, defaults identical):

- `dashcn/lib/src/components/chart/chart_tooltip.dart` — popover fill
  (defaults to `colors.popover`) frosts with ambient legs.
- `dashcn/lib/src/components/code_snippet/code_snippet.dart` — block fill
  (default `card`) frosts with ambient legs.
- `dashcn/lib/src/components/error_system/error_system.dart` —
  full-section `colors.background` overlay frosts with ambient legs.
- `dashcn/lib/src/components/feature_carousel/feature_carousel.dart` —
  section `colors.background` backdrop frosts with ambient legs (completes
  the earlier import-only edit).
- `dashcn/lib/src/components/search_bar/search_bar.dart` — popover surface
  (defaults to `colors.popover`) frosts with ambient legs.
- `dashcn/lib/src/components/toolbar/toolbar_surface.dart` — container fill
  frosts with component legs winning over ambient.

Docs:

- `docs/lib/widgets/docs_header.dart` — bar `Container color:
  theme.colors.background` now paints
  `surfaceColor(theme.colors.background, theme.surfaceOpacity)` inside
  `GlassSurface(surfaceBlur: theme.surfaceBlur)`; layout, heights, padding,
  nav, search trigger, buttons, and the `_HeaderFocusAnchor` focus path are
  unchanged.

Tests:

- `dashcn/test/registry/surface/surface_tokens_audit_test.dart` (new, 208
  lines) — one frost group per fixed family (`chart_tooltip`, `code_snippet`,
  `error_system`, `feature_carousel`, `search_bar`, `toolbar`): ambient
  `surfaceOpacity 0.5` + `surfaceBlur 8` gives a translucent fill
  (alpha <= 0.6) with a `BackdropFilter` present.
- `dashcn/test/registry/surface/surface_guard_test.dart` (new, 135 lines) —
  analysis guard: fails on a new direct `colors.background/card/popover`
  box-surface paint in `lib/src/components` without the primitive, with an
  allow-list and a reason per exception; also fails on stale allow-list
  entries.
- `dashcn/test/registry/surface/surface_everywhere_test.dart` — the six
  registry ids moved from allow-list to `_tested`
  (`chart`, `code_snippet`, `error_system`, `feature_carousel`,
  `search_bar`, `toolbar`) plus a header note pointing at the new test file.

Regenerated (generators only, no hand edits):

- `dashcn/lib/src/manifests/registry.json`,
  `dashcn/lib/src/manifests/scorecards.json`,
  `docs/lib/generated/docs_scorecards.dart`,
  `docs/lib/ui/dashcn/components/*` mirror (6 files).

## Test and gate results

- `dart format` on changed files: applied (docs_header re-indent is the
  expected one-level wrap; no behaviour change).
- `flutter analyze` (dashcn): no issues. `flutter analyze` (docs): no issues.
- `flutter test test/registry/surface/surface_tokens_audit_test.dart`: 6/6 pass.
- `flutter test test/registry/surface/surface_guard_test.dart`: 2/2 pass.
- `flutter test test/registry/surface/surface_everywhere_test.dart`: 36/36 pass.
- Touched component suites: `chart_tooltip` 16/16, `code_snippet` 26/26,
  `error_system` 19/19, `feature_carousel` 19/19, `search_bar` 30/30,
  `toolbar` 14/14 — all pass.
- `flutter test test/rearch` (dashcn): 42/42 pass (after manifest regen).
- `dart run tool/check_names.dart`: 0 hits.
- Docs: `flutter test test/focus_test.dart` 11/11 pass; full
  `flutter test` 910 pass; `gen_docs_data --check` up to date;
  `sync_registry.sh --check` up to date.
- `flutter build web --release --base-href /` (docs): built `build/web`.
- Browser rule: no audio played; no browser sessions opened (all verification
  via `flutter test` and the static web build).

## PR

- URL: TBD (filled after `gh pr create`).
- Base: `main`, repo `mibrar-dev/dashcn`, branch `feat/surface-tokens-audit`.

## Not done / follow-ups

- `scratchpad/ui/design/DESIGN.md` is missing; audit used the rule text +
  `navigation_bar` reference instead.
- Edited lib files `feature_carousel` (484), `code_snippet` (397),
  `error_system` (436), `search_bar` (436) and `docs_header` (547) already
  exceed ~300 lines before this change; this pass adds only the minimal
  wrap (no splits) to avoid behaviour risk. New test files are under 300.
- `FeatureCarouselCenterCard` (card fill) and `GhostCard` (muted fill) were
  left as-is: the audit scope is literal `background/card/popover` box paints
  and ghost fills are `muted`, not surface tokens; the carousel frost test
  asserts the backdrop specifically.
- Blocks/flows page backgrounds intentionally stay opaque (scaffold-body
  role); starters have no surface hits.
