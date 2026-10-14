# Brief P7-G1 — make the Gooey Toast behave like a real gooey toast (user report 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNG images yourself (model crashes on images). Evidence (orchestrator, release build, /docs/components/
gooey_toast, dark): `rearch/design/ours/screens/user-bugs-2026-10-11/gooey-toast-sequence.png`.
Reference behaviour: the "goey toast" / Sonner-style gooey notifications (search the web with agent-browser, SHORT
commands, e.g. "goey toast" / "gooey toast react" demos and Sonner docs): a compact pill appears at a fixed viewport
edge (default top-center, configurable position), with a metaball/gooey morph it expands into a body with title +
description (+ action), stays for a duration, collapses back to the pill and disappears; hovering pauses the timer;
multiple toasts stack; swipe/close dismisses; reduced motion → simple fade.

## Observed bugs (fix all, at the root)
1. A toast is visible on page load before any interaction (the preview auto-shows or a queue survives across
   examples/pages). Nothing may show until triggered; leaving a page clears its toasts.
2. The toast renders INSIDE the preview stage on top of its own trigger button (anchored at the trigger position).
   Toasts must render in an overlay at a fixed position of the hosting viewport/app (top-center default; position
   param), never covering the trigger; in the docs, use an app-level toast host so it appears at the window edge.
3. Contrast: the pill surface is nearly invisible on dark and the title + icon are blue (`chart`/info tone) on dark —
   use popover/card surface + border + shadow tokens; title foreground; status tone only on the icon (success/info/
   warning/error from semantic tokens), readable in light/dark and every preset.
4. It appears already expanded and never collapses or dismisses (still visible after 7s+). Implement the lifecycle:
   enter as pill → morph/expand → wait `duration` (default 4–6s, pause on hover/focus) → collapse → exit; `dismiss`
   API + close/swipe; a promise/loading variant if the API has one.
5. The "gooey" morph is two stacked rectangles. Implement a proper metaball morph (e.g. blurred shapes + alpha
   threshold via ShaderMask/ColorFilter matrix, or a CustomPainter path morph) between pill and body; 60fps, no jank;
   reduced motion → crossfade.
6. Previews: "Default", "Expanded", plus examples for success/error/warning/info, with action, and position variants;
   each example shows a trigger button only.
Tests: nothing shown before trigger; toast rect is at the configured viewport edge and does not overlap the trigger;
lifecycle timings (pill → expanded → collapsed → removed) with fake time; hover pauses; dismiss works; stacking;
contrast tokens per tone in light/dark; reduced motion path.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, `flutter build web --release`. Captures with agent-browser (a timed sequence after clicking the
trigger, light + dark) → `rearch/design/ours/screens/p7g1-*.png`. Report `rearch/reports/P7-G1.md`, `## RESULT`. No git.
