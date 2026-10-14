# Direction A — "Workbench"  (working brand name: **Plinth**)
MOOD: an engineer's bench. Blueprint dot-grid background (subtle), hairline rulers with tick marks,
monospace micro-labels (e.g. `radius 0.625rem`, `density compact`, `hue 24°`), ONE accent colour
(ember orange #E2552B light / #FF7A4D dark) on neutral paper #FAF8F5 / ink #141414. Calm, exact.
Type: Geist + Geist Mono. Motion: mechanical, critically damped, no bounce; ruler snaps; counters roll.
HOME: hero left = H1 "Build it once. Ship it on every screen. Own every line." + sub + install command
chip + 2 CTAs; hero right = a live mini-app (e.g. a finance/settings screen built from kit widgets) in a
device frame with a platform switcher (iPhone · Android · macOS · Web). Under it three physical-looking
RULERS (radius, density, hue) — dragging them changes the mini-app (implement with JS + CSS vars).
Sections: (1) "Same code, four screens" — one flow rendered in 4 frames side by side with one code panel
and a "lines changed: 0" counter; (2) "Knobs" — props playground preview; (3) "Screens & Flows" —
tabbed mini-apps (onboarding, auth, checkout, settings, chat) each with `flutter_shadcn add flow:checkout`;
(4) "Spec sheets" — trust scorecards styled like engineering datasheets; (5) "Start an app" —
`flutter_shadcn create` template picker with an animated terminal; footer.
THEMING ("Theme Bench"): 3 columns — paste box (CSS) -> token table filling row by row (token, CSS value,
Flutter value, swatch) -> live device frame; export tabs Dart / JSON / Figma tokens; preset strip (42).
