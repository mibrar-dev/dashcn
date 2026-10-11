# Brief P7-TS1 — Theme Studio: black/grey selectable, chart colours + fonts apply, fonts installable, faster switch + animation choices

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs,
CLI=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_cli (branch refactor/rearchitecture).
Do NOT open PNGs yourself. Context: `rearch/reports/P7-U3.md` (apply-on-select), `P7-WD.md` (switch perf + cross-fade),
`P6-T2.md` (rail UX). Reference: https://ui.shadcn.com/create and tweakcn.com (agent-browser, SHORT commands).
User bugs (2026-10-11):
1. Base colour and Theme colour pickers: tapping BLACK or GREY variants selects RED instead (index/id mapping bug —
   e.g. list order vs id lookup, neutral palettes filtered out, first-match fallback). Every swatch must select itself;
   add a test that taps each swatch and asserts the model value.
2. Chart colours: selecting a chart palette has no visible effect — chart1..5 tokens must update site-wide (home
   charts, studio chart blocks, dashboard blocks) on select.
3. Heading font and Body font: selecting does nothing. Make them apply site-wide (headings = typography h1–h4/large;
   body = everything else) with real font families. Bundle a curated set as docs assets (e.g. Inter, Geist, Geist Mono,
   Manrope, DM Sans, Outfit, Plus Jakarta Sans, Space Grotesk, IBM Plex Sans, JetBrains Mono, Playfair Display,
   Lora — OFL licensed, include license files) and load lazily (FontLoader) so switching is fast.
   INSTALLABLE: the theme JSON/app_theme carries `fontFamily.heading/body/mono`; the CLI `theme apply` / Get Code output
   includes the font families, and the CLI adds the font assets + pubspec `fonts:` entries (or prints exact steps if
   files can't be fetched) — implement in the CLI repo with tests; Get Code dialog shows the pubspec snippet.
4. Faster switching: verify P7-WD's single-swap path is used for every Theme Studio change (preset, colours, radius,
   fonts, density, shadows); measure and report frame times; no frame > ~32ms after the first.
5. Switching animations: add a selectable "Transition" option in the rail (persisted): None, Fade (cross-fade),
   Circular reveal (from the click point), Wipe/slide, Blur-dissolve; all reduced-motion aware, GPU-cheap (snapshot
   based), ~250–400ms.
Tests: each bug + transitions; Gates: kit `rearch/qa_gate.sh`; docs format/analyze/test/codegen --check/sync --check/build
web --release; CLI format/analyze/test (+ e2e if theme apply touched). Captures → `p7ts1-*.png`. Report
`rearch/reports/P7-TS1.md`, `## RESULT`. No git ops. Other agents active: TH1 (docs theming of widgets), WB, WC — touch
only Theme Studio / theme state / fonts / CLI theme files.
