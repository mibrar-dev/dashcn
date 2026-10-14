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
