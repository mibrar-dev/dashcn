# Direction C — "Prism"  (working brand name: **Facet**)
MOOD: Flutter paints every pixel, so the site is one spatial canvas. Dark-first (near-black #0B0B0F,
light mode #F7F7FA), saturated accent glow (violet #7C5CFF -> cyan #22D3EE used sparingly as light, not
as flat gradient fills), depth, subtle grain/noise, thin connector lines. Type: Geist + Geist Mono.
Motion: camera pan/zoom, parallax depth, glow pulses.
HOME: hero = a FLOW MAP: 5-6 phone screens (onboarding -> sign in -> home feed -> product -> checkout ->
success) laid out on a dotted infinite canvas with curved connector lines and small labels; H1 overlaid
top-left "One canvas. Every platform. Your code." Clicking a screen zooms into it (CSS transform). Sections:
(1) "The prism" — one Button/Dialog entering a prism (SVG) and refracting into iOS / Android / desktop /
web frames; (2) "Flows you can install" — flow cards each a mini flow map + `flutter_shadcn add flow:auth`;
(3) "Motion Lab" — curve editor in a floating glass panel over the canvas; (4) "Scorecards" — HUD-style
overlays pinned to screens (contrast AA, semantics, RTL, tests); footer.
THEMING ("Spectrum"): themes as light through a prism — left panel pick/paste a theme, the flow map on the
canvas re-tints in real time; token inspector as a HUD; export Dart/JSON/Figma.
Make sure it also reads at 375 (canvas becomes a vertical stack of screens).
