# Brief P7-WD — theme switching is slow ("feels stuck") + add a theme-switch animation
KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (the model crashes on images). Reference look: ui.shadcn.com docs pages + the deployed main site https://mibrar-dev.github.io/shadcn_flutter_kit/ (agent-browser, SHORT commands; Flutter canvas → click by coordinates). Previews must be BEAUTIFUL, realistic, working examples (users install what looks great), centred, theme-token driven, light/dark. Fix at the root; tests that interact. Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, format/analyze/test, build web --release. Other agents are active in the same tree (TH1 docs theming, CP1 colour picker, NM1 navigation menu, and the other P7-W batches) — touch only your files; if a gate fails only on their in-flight files, record it. No git ops.
Owns: docs theme state/app root (docs_state, site_theme_model, main/app shell theme wiring), registry theme animation
(AnimatedShadcnTheme / ShadcnApp theme transition) — coordinate with TH1 (it replaces hard-coded values in docs widgets;
don't edit those widget files).
1. Measure: switching preset / light-dark / Theme Studio select takes too long and the UI freezes. Profile (release build
   + timeline/frame timings in a widget/integration test, count rebuilds) and find the cause (e.g. full-tree rebuild with
   lerped ThemeData every frame, persistence on the UI thread, regenerating text styles/fonts, deferred previews rebuilt,
   masonry relayout). Fix: a single theme swap per commit, cheap lerp (colours only) or snapshot-based transition,
   RepaintBoundaries around heavy sections, persistence async after the frame, font loading cached.
2. Theme switch animation: a smooth transition on theme change (e.g. circular reveal from the toggle/click point or a
   ~250ms cross-fade of a snapshot of the old frame over the new one), works for light/dark toggle and preset changes,
   reduced motion = instant; no jank (target ≤ 16ms frames after the first).
3. Report before/after numbers (frame build/raster times, time-to-interactive after switch).
Tests: one notification per commit, transition completes, reduced motion path. Report `rearch/reports/P7-WD.md`, `## RESULT`.
