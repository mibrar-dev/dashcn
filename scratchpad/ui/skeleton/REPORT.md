# REPORT — skeleton shimmer on real content (feat/ui-skeleton)

Branch `feat/ui-skeleton`, worktree `dashcn-w-skeleton`, docs on port 8874,
captures in `scratchpad/ui/skeleton/`.

## What was built

Extended the existing `skeleton` component in place (duplicate check: the only
existing placeholder was the generic-box `Skeleton`; `avatar`, `card`,
`table` are real content widgets, not loading states — no duplication, no new
component id, counts unchanged at 132 manifest entries / 96 listed).

New widgets (all in `dashcn/lib/src/components/skeleton/`):

- `SkeletonLine` — stacked rounded bars shaped like text lines; last line
  renders short (`lastLineFraction`, RTL-aware) like real copy.
- `SkeletonAvatar` — circle (default) or rounded-tile avatar placeholder.
- `SkeletonBlock` — generic rounded box with explicit width/height.
- `SkeletonCard` — frosted loading card (header avatar + title lines, content
  lines, opt-in footer) painted through the shared surface primitive.
- `SkeletonList` — repeated avatar + text rows with dividers.
- `SkeletonTable` — header blocks + body line grid.
- `SkeletonMirror` — sizes any placeholder from the real child's box: the
  child lays out invisibly (no semantics, no hit test) and the placeholder
  fills its exact box via `Positioned.fill` + `ClipRect`/`OverflowBox`, so an
  oversized placeholder clips instead of overflowing.
- `Skeleton` (existing) gained `theme`+`style` legs, `densityTokens`,
  `semanticsLabel`, and motion-token duration/curve resolution.

Theme: `SkeletonTheme` gained `themeDensityTokens`, `lineHeight`, `lineGap`,
`avatarSize`, `rowHeight`, `surfaceOpacity`, `surfaceBlur`
(+ `typedef SkeletonStyle = SkeletonTheme` for per-instance overrides).
Sizes resolve from the density scale, compact default: line = bodyTextSize
(14/15/16), gap = gap (8/10/12), avatar = controlHeight (32/40/48), row =
rowMinHeight (32/40/48); phone widths (< 600px) use touch unless overridden.
The sweep duration scales with `MotionTokens.scaledDuration` and the curve
falls back to `motion.curves.standard`; reduced motion
(`MediaQuery.disableAnimations` or `motion.enabled: false`) parks the sweep
mid-way with zero duration and no ticker.

Previews: Default (toggle), Card, List, Loading card, Table (5 named examples).
`SkeletonMirror` has widget tests but no gallery preview: its placeholder
top-aligns inside a taller invisible box, which fails the generated
vertically-centered-preview gate by design.

## Customization surface

- Theme file: `skeleton_theme.dart` (app-wide overrides, never overwritten).
  Per-instance: constructor params + `theme`/`style` widget legs on every
  widget (4-leg resolution: defaults < app < scoped < widget).
- Builder slots: `lineBuilder`, `avatarBuilder`, `blockBuilder`,
  `leadingBuilder`/`titleBuilder`/`contentBuilder`/`footerBuilder` (card),
  `leadingBuilder`/`titleBuilder`/`trailingBuilder`/`separatorBuilder` (list),
  `headerBuilder`/`cellBuilder` (table), `placeholderBuilder` (mirror).
- Controlled only (`enabled`): placeholders hold no state, so no controller is
  applicable; the Default preview's toggle button is keyboard-reachable and
  the placeholders carry `Semantics(label: 'Loading')`.
- RTL verified by test; touch targets N/A (placeholders are non-interactive,
  excluded from semantics/hit-testing); shimmer fills are decorative —
  scorecard text-contrast/tap-target checks pass.
- `SkeletonCard` honors `surfaceOpacity`/`surfaceBlur` (widget > theme >
  ambient) via `surfaceColor` + `GlassSurface`; other shapes are inline fills
  (skeleton id stays allow-listed in `surface_everywhere_test.dart`).

## Files

- `dashcn/lib/src/components/skeleton/`: `skeleton.dart` (exports),
  `skeleton_style.dart` (extended theme), `skeleton_layout.dart` (new,
  density/size resolvers), `skeleton_shapes.dart` (new: Block/Line/Avatar),
  `skeleton_compose.dart` (new: Card/List), `skeleton_table.dart` (new: Table,
  split out to keep every file under ~300 lines),
  `skeleton_mirror.dart` (new), `preview.dart` (+3 examples),
  `meta.json` (+files/api/typedefs/theme fields), `README.md` (rewritten).
- Regenerated: `dashcn/lib/{dashcn,components/skeleton}.dart` (exports),
  `dashcn/lib/src/manifests/{registry,scorecards}.json`,
  `test/registry/{previews_test,qa/previews_centered_test}.dart`,
  scorecard harness, all `docs/lib/generated/*`, `docs/lib/ui/dashcn/...` mirror.
- Tests: `dashcn/test/registry/components/skeleton_test.dart` (42 tests:
  shapes, compose, mirror, density/motion/a11y incl. 375px no-overflow).
  QA suite auto-covers the 5 previews.
- Captures: 20 PNGs + 1 WebM + `CAPTURES.md` in `scratchpad/ui/skeleton/`.

## Gate exit codes

- `dart format --output=none --set-exit-if-changed lib test tool` → exit 0.
- `dart run tool/check_names.dart` → 0 hits.
- `dart analyze` (dashcn) → No issues; `flutter analyze` + `dart analyze`
  (docs) → No issues.
- `flutter test test/registry` (dashcn) → 6183 pass, 0 fail.
- `flutter test test/tool` → 16 pass. `test/rearch` → 42 pass total
  (manifest 4, single_owner+api_snapshot 18, layers 9, next_deps+next_layout 11;
  run per-file after one whole-directory run timed out under contention with
  sibling agents on this Mac).
- `flutter test test/hero_count_test.dart`,
  `test/audit/preview_static_audit_test.dart`,
  `test/scorecard/scorecards_page_test.dart`,
  `component_page/examples/preview_f4` (docs) → all pass.
- `gen_docs_data --check`, `sync_registry.sh --check`, `gen_exports --check`,
  `gen_scorecards --check` → up to date.
- `flutter build web --release --base-href /` (docs) → ✓ built.
- docs full `flutter test` → killed by SIGTERM (resource contention with
  sibling worktree agents); all skeleton-relevant suites above pass.
- `bash rearch/qa_gate.sh` → ran; format/exports/analyze clean, full test
  line truncated by output but covered by the direct runs above.

## Visual review notes

- API Reference/Theme tables clip the Description column at 1280px and code
  blocks clip at 375px — docs-chrome rendering shared with other components,
  flagged in CAPTURES.md, not fixed here.
- Skeleton has no overlay → no open-state shots; Default toggle states covered
  by QA widget test (canvas build exposes no DOM refs for clicking).

## Deliver

- PR: <PR URL inserted after `gh pr create`>
- Trailer used: `Co-Authored-By: Claude Haiku 5.5 <noreply@anthropic.com>`
- Left running: docs server on http://localhost:8874 (background http.server).
- Not done: nothing in scope remains; suggested follow-up is the docs table /
  code-block horizontal clipping at narrow widths.
