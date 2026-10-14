# Step 1 — Brainstorm: creative directions + brand (2026-10-12)

Status: proposed, awaiting picks. Constraints carried: widgets-only Flutter, token-driven
(radius/colour/font/density/shadow), light+dark, 375→1440, files ≤ ~400 lines, registry
components first. Assets on hand: 118 components, 18 blocks, 42 theme presets, codegen API
data (docs_api.dart), motion scope, Theme Studio.

## The thesis (all directions share it)
shadcn's site says "here are components". Ours says **"here is a running app, on every
platform, in your theme — and you own the code."** Every hero pixel is a real registry
widget, not a screenshot. That is the one thing a web component library cannot copy.

---

## Direction A — "Workbench" (precise, tool-like, developer-first)
- **Mood:** an engineer's bench. Blueprint dot-grid, hairline rulers with tick marks,
  mono micro-labels (`radius 0.625rem`, `density compact`), one accent colour. Calm,
  exact, Linear/Raycast-adjacent but warmer.
- **Hero:** left = H1 + install command; right = a live mini-app inside a device frame
  with a **platform switcher** (iPhone · Android · macOS · Web). Beneath it, three
  physical-looking **rulers** (radius, density, hue). Drag one → every widget in the frame
  re-lerps live.
- **Sections:**
  1. *Same code, four screens* — one flow rendered in 4 frames side by side; a single
     code panel in the middle with a "lines changed: 0" counter.
  2. *Knobs* — props playground fed from docs_api.dart; code panel diffs as you turn knobs.
  3. *Screens & Flows* — tabbed mini-apps (onboarding, auth, checkout, settings, chat),
     each `flutter_shadcn add flow:checkout`.
  4. *Spec sheets* — trust scorecards styled like datasheets (semantics ✓, contrast AA,
     RTL ✓, tests 37, rebuild cost).
  5. *Start an app* — `flutter_shadcn create` template picker, terminal animates.
- **Theming section ("Theme Bench"):** 3-column — paste box (CSS/tweakcn/Tailwind) →
  token table that fills in row by row → live device frame. Export tabs: Dart · JSON ·
  Figma tokens.
- **Motion:** mechanical. Critically-damped springs, no bounce, ruler snaps, counters roll.
- **Sample copy:** "Build it once. Ship it on every screen. Own every line."
  / "Drag the ruler. That's a ThemeData lerp, at 120 fps."
- **Trade-off:** most useful + easiest to build well; least "wow" for non-developers.

## Direction B — "Kiln" (tactile, theme-first, editorial)
- **Mood:** craft studio. Warm off-white / deep charcoal, editorial serif headlines over a
  clean sans, generous whitespace, swatch chips like glaze tiles.
- **Hero:** one big composite card (login + chart + toast) that **"fires" through the 42
  presets** — every 3 s it morphs (colours, radius, shadow, font) with Flutter's
  ThemeData lerp. A row of glaze tiles below; click one to stop on it.
- **Sections:**
  1. *Bring your glaze* — the theme bridge as the centrepiece: paste shadcn/tweakcn CSS,
     watch the card adopt it.
  2. *Motion Lab* — gooey toast, theme transitions, a draggable cubic-bezier curve editor
     driving a live preview.
  3. *Recipes* — app starters presented as recipe cards (ingredients = blocks + theme).
  4. *Every platform* — quieter: a single frame that rotates phone ↔ desktop.
- **Theming section ("The Kiln"):** full-bleed: preset strip on top, giant live canvas,
  floating token inspector; "fire" button cross-fades old → new theme.
- **Motion:** fluid, slow lerps (400–600 ms), gooey blobs, colour bleed.
- **Sample copy:** "Shape it. Fire it. Ship it." / "42 glazes. Or paste your own."
- **Trade-off:** most beautiful and memorable; theming-heavy, weaker on "every platform"
  and developer trust signals.

## Direction C — "Prism / Canvas" (spatial, bold, dark-first)
- **Mood:** Flutter paints every pixel — so the site is one zoomable canvas. Dark-first,
  saturated accent glow, depth, subtle grain.
- **Hero:** a **flow map** — onboarding → auth → home → checkout screens laid out on an
  infinite canvas (InteractiveViewer) with connector lines. Scroll zooms the camera into
  one screen, which becomes interactive. A "prism" splits one widget into 4 platform
  renderings.
- **Sections:**
  1. *The prism* — a button/dialog refracted into iOS/Android/desktop/web frames.
  2. *Flows you can install* — the flow map per template.
  3. *Motion Lab* — curve editor in a floating panel over the canvas.
  4. *Scorecards* — HUD-style overlays on each screen.
- **Theming section ("Spectrum"):** themes as light through a prism: pick/paste a theme
  and it "refracts" across the flow map in real time.
- **Motion:** camera moves (pan/zoom), parallax depth, glow.
- **Trade-off:** most unique, nothing like shadcn; highest build + perf risk on Flutter web
  (canvas of many live screens), harder at 375 px.

---

## Recommendation
**A as the skeleton, borrowing B's preset morph for the hero and C's flow map for the
Screens & Flows section.** A delivers the most of ideas 1–7 with the lowest risk, and the
borrowed pieces give it the "wow" it lacks alone.

---

## Brand
pub.dev availability checked 2026-10-12 (`/api/packages/<name>` → 404 = free). Trademark /
domain not checked yet. Avoid anything near `shadcn_ui`, `shadcn_flutter`, `forui`.

| Name | Package (free) | Concept | Fits |
|---|---|---|---|
| **Kiln** | `kiln`, `kiln_ui` | you shape components, then "fire" them in your theme | B, A |
| **Facet** | `facet`, `facet_ui` | one widget, many faces (platforms, themes) | C, A |
| **Plinth** | `plinth`, `plinth_ui` | the base you build on; you own the stone | A |
| **Quarry** | `quarry`, `quarry_ui` | take the blocks out, they're yours | A |
| **Loom** | `loom_ui` | weave screens into flows | C |

Taken on pub.dev: `tessera`, `keel`, `veneer`.

**Logo concepts:** Kiln — a rounded-square tile with a flame-shaped negative cut (the
squircle is literally the radius token). Facet — a cut-gem hexagon whose faces are four
platform tints. Plinth — stacked slabs, top slab offset by the radius.

**Palette (Kiln / A-default):** neutral base from `neutral` preset; accent "ember"
`#E2552B` (light) / `#FF7A4D` (dark); success sage `#5E8B6A`; ink `#141414` / paper
`#FAF8F5`. Facet alternative: violet→cyan gradient accent on near-black.

**Type:** UI + body *Geist* (or Inter), code *Geist Mono / JetBrains Mono*, display (B only)
*Instrument Serif*.

**Voice:** direct, builder-to-builder, short sentences, verbs first, numbers over
adjectives ("0 lines changed", "AA on 42 themes"). No hype words.

**Naming decision (pending):** recommend plain widget names (`Button`, `Dialog`) and a
brand prefix only on the theme types that collide with Flutter (`KilnTheme`,
`KilnThemeData`). Needs your call before any rename.
