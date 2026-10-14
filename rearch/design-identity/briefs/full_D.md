# Shared brief — design-identity mockups (all directions)

PRODUCT: a copy-paste-and-own Flutter UI kit (118 widgets, 18 blocks, 42 theme presets, a CLI
`flutter_shadcn add button`). Pure Flutter widgets (no Material/Cupertino), every visual is a theme
token (radius, colours, fonts, density, shadows), light + dark, runs on iOS, Android, desktop, web.
The current docs site is a near-clone of ui.shadcn.com — we want our OWN identity. Keep developer
conventions: top nav, docs sidebar, Cmd-K search, component-page anatomy (title, description,
Preview/Code tabs, install command, usage, API table, TOC on the right).

THESIS: "a running app, on every platform, in your theme — and you own the code." Every hero visual
must look like a real, live UI (buttons, inputs, cards, toasts, tab bars, charts) — never stock
illustrations, never lorem ipsum, never purple-gradient AI-slop.

DELIVERABLES (static HTML+CSS, inline JS allowed for small interactions, no external images; draw
device frames with CSS/SVG):
1. `home.html` — top nav + hero + the unique home sections listed in your direction + footer.
2. `theming.html` — the theming section/page described in your direction (theme bridge: paste a
   shadcn/tweakcn/Tailwind CSS theme -> Flutter tokens -> live preview; export Dart / JSON / Figma tokens;
   42 presets).
3. `component.html` — the Button component page inside the docs shell: sidebar, article, TOC; the
   preview area has a PLATFORM SWITCHER (iPhone / Android / Desktop / Web device frames, same widget)
   and a PROPS PLAYGROUND (knobs: variant [default, secondary, outline, ghost, destructive, link],
   size [sm, default, lg, icon], disabled, loading, label text, leading icon) that updates the preview AND
   the shown Dart code (`Button(variant: ButtonVariant.outline, size: ButtonSize.sm, child: Text('Save'))`).
   Then install command `flutter_shadcn add button`, usage, API table, and a TRUST SCORECARD
   (Semantics ✓, contrast AA on 42/42 themes, RTL ✓, 37 tests, keyboard ✓).
4. `index.html` — a simple chooser linking the three pages.

REQUIREMENTS: design at 1440 wide, must also work at 375 (responsive CSS, mobile nav collapses).
Light + dark: CSS variables on :root, `[data-theme=dark]` overrides, a toggle in the nav.
All colours/radii/fonts as CSS custom properties (they map to Flutter tokens later).
Fonts: Google Fonts allowed (Geist, Geist Mono, Inter, JetBrains Mono, Instrument Serif).
Copy: direct, builder-to-builder, short, numbers over adjectives. No hype words ("revolutionary", "supercharge").
Use the working brand name given in your direction (placeholder; final name TBD).
Quality bar: Linear / Vercel / Raycast / Rauno-level craft. Real spacing system, tight type scale,
consistent radii, believable content. Finish all 4 files completely; don't ask questions — decide.
# Direction D — "Hybrid"  (working brand name: **Plinth**)
= Direction A "Workbench" as the skeleton, plus B's preset morph in the hero and C's flow map for Screens & Flows.
MOOD: A's precision (dot-grid, hairline rulers, mono micro-labels, Geist + Geist Mono, ember accent #E2552B /
#FF7A4D on paper #FAF8F5 / ink #141414) warmed slightly by B (glaze-tile swatches, smooth theme lerps).
HOME: hero left = H1 "Build it once. Ship it on every screen. Own every line." + install chip + CTAs; hero
right = live mini-app in a device frame with platform switcher (iPhone · Android · macOS · Web) that ALSO
morphs through theme presets every 3s (B), with a glaze-tile row + three rulers (radius, density, hue) beneath
(dragging pauses the morph). Sections: (1) "Same code, four screens" (A); (2) "Knobs" props playground (A);
(3) "Screens & Flows" as a C-style FLOW MAP on a dotted canvas with connector lines, tabs switch flow
(onboarding, auth, checkout, settings, chat), each with `flutter_shadcn add flow:<name>`; (4) "Motion Lab"
strip with a cubic-bezier curve editor (B); (5) "Spec sheets" trust scorecards (A); (6) "Start an app"
`flutter_shadcn create` terminal (A); footer.
THEMING ("Theme Bench"): A's 3-column paste -> token table -> live device frame, plus B's glaze-tile preset
strip and a smooth cross-fade "Apply" transition; export Dart / JSON / Figma.
