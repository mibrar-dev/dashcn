# P9-4a — Bring your web theme: pure-Dart converters

Prerequisite: P8-2 accepted. Spec: `DASHCN_FEATURES_PLAN.md` §P9-4 (binding). Read `$APP/lib/src/theme/**` (the
ThemeData/colour token model), the preset JSON under `$APP/lib/src/themes*` (verify path), `$DOCS/lib/theme/**`
(ThemeDocument, export), and the CLI's `theme_css.dart` (read-only, for overlap).

## Tasks
1. `$APP/lib/src/theme/interop/` with **no `package:flutter` import** (pure Dart, so the CLI can vendor it):
   - `color_space.dart`: parse/format oklch, oklab, hsl (incl. shadcn v3 bare triplets `222.2 47.4% 11.2%`), rgb,
     hex(3/4/6/8); conversions via linear sRGB; gamut mapping for out-of-gamut oklch (chroma reduction); ΔE2000.
   - `css_theme_parser.dart`: `:root {}` + `.dark {}` (+ `[data-theme]` variants), shadcn v3/v4 + tweakcn variables
     (colours, `--radius`, `--font-*`, `--shadow-*`, `--chart-*`, `--sidebar-*`, `--spacing`, `--letter-spacing`),
     Tailwind v4 `@theme {}` (`--color-*`).
   - `tailwind_v3_parser.dart`: restricted object-literal parser for `theme.extend.colors` (strings, nested shades,
     `hsl(var(--x))` references); no JS evaluation.
   - `theme_model.dart`: neutral `WebTheme` (light/dark token maps + radius/fonts/shadows) + `ImportReport`
     (mapped/defaulted/ignored, with reasons).
   - `writers/`: `shadcn_css_writer.dart` (v4 oklch), `tailwind_v4_writer.dart`, `dtcg_writer.dart` (W3C Design
     Tokens `.tokens.json`, light/dark modes for Figma Variables), `dashcn_theme_writer.dart` (the kit's preset JSON
     shape).
   - `mapping.dart`: WebTheme ↔ kit token names. It is one table, documented, and every kit token is covered or
     reported.
2. Tests `$APP/test/registry/theme/interop/`: colour-space conversions vs reference values, round-trip for all 42
   presets (`parse(write(t))` within ΔE2000 < 0.5, exact for radius/fonts), 5 real tweakcn-style fixtures (write them
   from tweakcn's public format; mark the source), a fuzz test (random/garbage input never throws and always
   returns a report), Tailwind v3 literal cases.

## Owns
`$APP/lib/src/theme/interop/**`, `$APP/test/registry/theme/interop/**` (fixtures included). Add the interop library
to the exports generator inputs only if P8-1's tool requires a manifest entry (say which).

## Gates
`rearch/qa_gate.sh` (layers: interop sits in theme and must not import components), `gen_exports --check`,
`check_names`.

## Report
`$KIT/rearch/reports/P9-4a.md`
