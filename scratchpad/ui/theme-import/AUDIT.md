# Variable audit: sample Tailwind v4 theme → dashcn tokens

Source: `sample_tailwind_theme.css` (copied from the brief's input; a
Tailwind v4 theme with `:root` + `.dark` blocks, `@theme inline`, shadows,
tracking, radius, spacing, and Orbitron/Rajdhani/Fira Code fonts).
Parser: `dashcn/lib/src/theme/interop/` (`parseCssTheme`), as of this batch
(`--preset` string codec + font catalogue + at-rule report lines +
`--shadow-x/-y` aliases).

Headline: **122 mapped, 0 defaulted, 38 ignored** — every schema-required
token comes from the source, and every leftover has a report line. Nothing
is dropped silently.

## 1. Colours — all 32 tokens × light + dark: USED

| Variable(s) | dashcn token | Notes |
|---|---|---|
| `--background` … `--ring` (19 vars) | same name, camelCased | `oklch()` in both modes; per-mode maps stay separate (dark background ≠ light) |
| `--chart-1` … `--chart-5` | `chart1` … `chart5` | all five, both modes |
| `--sidebar`, `--sidebar-foreground`, `--sidebar-primary`, `--sidebar-primary-foreground`, `--sidebar-accent`, `--sidebar-accent-foreground`, `--sidebar-border`, `--sidebar-ring` | same names | v3-era `--sidebar-background` still accepted as an alias for `sidebar` |
| `@theme inline` `--color-*` (32 aliases) | same 32 tokens | `var(--x)` refs resolved per mode; raw colours fill both modes |

All three notations in the wild (`oklch()` here, `hsl(... / alpha)`,
`#hex`) parse to the same ARGB. Proposal: none — complete.

## 2. Radius, spacing — USED

| Variable | dashcn token | Notes |
|---|---|---|
| `--radius: 0rem` (both modes) | `radius` (rem number) | sample value `0` — sharp corners survive the import |
| `--radius-sm/-md/-lg/-xl` (`@theme`) | — | IGNORED, reason `derived radius step; recomputed from --radius at build`. Proposal: keep ignoring — the kit rebuilds the steps, storing them would fork the scale. |
| `--spacing: 0.25rem` (`:root` only) | `spacing` (rem) | mode-independent; `.dark` correctly omits it |

## 3. Shadows — atoms USED, sizes derived

| Variable | dashcn token | Notes |
|---|---|---|
| `--shadow-color` | `shadow.{light,dark}.color` | `#bc13fe` light / `#ff0055` dark |
| `--shadow-opacity` | `shadow.{mode}.opacity` | 0.6 / 0.8 |
| `--shadow-blur` | `shadow.{mode}.blur` (px) | 12 / 20 |
| `--shadow-spread` | `shadow.{mode}.spread` (px) | 2 / 4 |
| `--shadow-x` / `--shadow-y` | `shadow.{mode}.offsetX / offsetY` | **New in this batch**: were `unknown variable` before; Tailwind v4 shorthand aliases for the canonical `--shadow-offset-x/-y` the writers emit. 0px in both modes here. |
| `--shadow-2xs … --shadow-2xl` (8 sizes × 3 blocks: `:root`, `.dark`, `@theme`) | — | IGNORED, reason `derived shadow size; recomputed from shadow atoms at build`. Proposal: keep ignoring — the eight sizes are rebuilt from the atoms at build time by `ShadowScale.derive`; importing them would freeze one scale. |

## 4. Tracking — normal USED, rest proposed

| Variable | dashcn token | Notes |
|---|---|---|
| `--tracking-normal: 0.1em` (`:root`) + `@theme` self-alias | `tracking.normal` (em) | used |
| `--tracking-tight` / `--tracking-wide` (`@theme`: `calc(var(--tracking-normal) ∓ 0.025em)`) | `tracking.tight` / `tracking.wide` exist but stay defaulted | IGNORED, reason `not a length: calc(…)`. The kit HAS these two tokens; the values (0.075em / 0.125em) are computable but the parser does not evaluate `calc()`. **Proposal: evaluate single-operation `calc()` in `@theme` aliases as a follow-up** so these map to the existing tokens instead of defaults. |
| `--tracking-tighter` / `--tracking-wider` / `--tracking-widest` (`@theme`) | no kit token | IGNORED, reason `layout scale; no kit token counterpart`. **Proposal: ignore with reason** — the type scale resolves three steps (normal/tight/wide); adding tighter/wider/widest would need a schema addition with no consumer. Revisit if a component needs finer steps. |
| `body { letter-spacing: var(--tracking-normal); }` | — | A plain CSS *property*, not a `--variable`; duplicates `tracking.normal`. Not imported by design; noted here so it is not "silent". |

## 5. Fonts — USED

| Variable | dashcn token | Notes |
|---|---|---|
| `--font-sans: 'Orbitron', sans-serif` | `fonts.sans` | stack preserved verbatim |
| `--font-serif: 'Rajdhani', sans-serif` | `fonts.serif` | stack preserved verbatim |
| `--font-mono: 'Fira Code', monospace` | `fonts.mono` | stack preserved verbatim |

All three resolve in the bundled Google Fonts catalogue (see
`google_fonts_catalogue.dart`), so the CLI default is Google Fonts;
a made-up family resolves to the local `dashcn font add` path with a
report line. `@theme` self-aliases (`--font-sans: var(--font-sans)`)
resolve against the mode maps and re-map to the same slots.

## 6. Directives — REPORTED (new in this batch)

| Statement | Report line |
|---|---|
| `@import "tailwindcss";` | `stylesheet import; not a theme token` |
| `@custom-variant dark (&:is(.dark *));` | `dark-variant helper; the .dark block already carries dark mode` |
| `@layer base` | `wrapper only; inner declarations still parsed` |
| `@apply border-border outline-ring/50;` (`*` rule) | `build-time utility inlining; not a theme token` |
| `@apply bg-background text-foreground;` (`body` rule) | `build-time utility inlining; not a theme token` |

Before this batch the directives above were skipped without a trace;
existing fixture tests that asserted empty `ignored` lists pinned that
silence and were updated (`web_css_fixtures_test.dart`,
`theme_web_bridge_test.dart`).

## 7. Coverage proof

`sample_tailwind_v4_import_test.dart` asserts: every variable declared in
`:root` (52) and `.dark` (50) is in `mapped ∪ ignored`; at-rule lines are
present with the reasons above; light/dark colours stay in their mode;
fonts/radius/spacing/tracking/shadow atoms equal the sample values; the
`@theme` `var()` aliases resolve rather than drop.
