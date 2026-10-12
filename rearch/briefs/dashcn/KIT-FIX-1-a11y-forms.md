# KIT-FIX-1 — accessibility + form-validation fixes found by the scorecards and reviews

You work in worktree B (branch `wip/kit-fix-1`). Another agent edits docs pages in the main worktree. Read
`$KIT/rearch/reports/P9-5a.md` (findings), `$APP/lib/src/manifests/scorecards.json`, `$APP/tool/gen_scorecards.dart`,
and the scorecard examples in `$APP/test/scorecards/examples/`.

## 1. Text contrast (47 components fail)
Verified root cause: muted-foreground text on muted surfaces — neutral preset `#737373` on `#F5F5F5` = 4.35:1 (< WCAG AA
4.5:1; it passes on white at 4.74). Fix at the source, not per component:
- Find every place the kit paints `mutedForeground` text on a `muted`/`secondary`/`accent` surface (badges, secondary
  buttons, list hovers, tabs, inputs' placeholders on muted fills…). Where the surface is muted, use a darker text
  token that meets 4.5:1 against it (in light AND dark), e.g. derive an "onMuted" foreground in the theme from the
  preset colours with a contrast guarantee (compute with the interop colour maths: `lib/src/theme/interop/internal`
  has CIEDE2000/oklch; add a small WCAG contrast helper with tests). Do not edit the 43 preset JSON files' upstream
  values; derive the safe colour at theme build time.
- Re-check the remaining failures in the regenerated scorecards (the "1.0–2.8 fills" ones may be measurement
  artefacts of icons/borders — investigate each; fix real ones, document artefacts in the report with evidence).
Target: textContrast passes for every component where the failure is real.

## 2. Labels and semantics
- 11 unlabeled tap targets: give each interactive element an accessible label (`Semantics(label:)`, tooltip, or the
  component's own label param) — icon-only buttons in particular.
- 5 components without semantics (divider, image, spinner, tooltip, tracker): divider → `Semantics(container)`/
  excluded as decorative with a note; image → label from `semanticLabel`; spinner → "Loading" progress semantics;
  tooltip → the message as hint; tracker → value semantics.
- Tap targets 32–36 px (22 components): these are desktop-density sizes by design. Do NOT inflate controls; instead
  make sure hit areas reach 44×44 on touch platforms where it is free to do so (e.g. extend the hit-test area, not the
  visual size, under `TargetPlatform.android/iOS`), and record per component in the report whether it now passes.

## 3. Form validation at mount
`FormValidationMode.changed` fires during the initial mount, so `{changed}` / `{changed, submitted}` show errors before
any edit (seen in the `login-01` block and the flows). Fix in `primitives/form_core`: "changed" must mean a value change
after mount (track a dirty/pristine flag); `initial` stays the explicit opt-in for mount-time errors. Add tests: no
errors on mount with `{changed}`; errors after the first edit; `{initial}` still validates at mount; the login-01 block
and the five flows render with no errors on first frame. Keep the flows' `{submitted}` as is.

## Then
Regenerate everything (`gen_scorecards`, manifest, previews/blocks tests, exports, docs mirror + docs data), and put
before/after scorecard numbers in the report. Gates: `rearch/qa_gate.sh`, every generator `--check`, `check_names`,
`dart format --set-exit-if-changed .` in `$APP`; docs `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`,
then `gen_docs_data --check`, `sync_registry --check`, `flutter analyze`, `flutter test test tool`.

## Report
`$KIT/rearch/reports/KIT-FIX-1.md`
