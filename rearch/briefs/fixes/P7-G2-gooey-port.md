# Brief P7-G2 — port the WORKING gooey toast from `main` into the new registry, with its full playground

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself (model crashes on images); reference captures of the deployed main site are in
`rearch/design/main-ref/gooey-toast/` and described below. Live reference (agent-browser, SHORT commands):
https://mibrar-dev.github.io/shadcn_flutter_kit/#/components/gooey_toast (Flutter canvas: click by coordinates).

User (2026-10-11): the new gooey toast is broken; the one on `main` works perfectly and has many stages, shapes and
animations — bring that back and present all of it in the previews.

## Source of truth (read fully first)
- `git show origin/main:flutter_shadcn_kit/lib/registry/components/overlay/gooey_toast/...` (gooey_toast.dart, _impl/core/
  {constants,controller,defaults,models,widget}.dart, _impl/themes/**, _impl/utils, README, GETTING_STARTED, preview).
- Its docs playground: `git ls-tree -r origin/main docs/lib/pages/docs/components/gooey_toast/` (+ component_examples).
## Observed main behaviour (must match)
Top-centre default; a rounded tab-shaped PILL (status icon + coloured title) that grows a wider BODY below it through
smooth concave shoulders (`_buildGooeyShapePath` / body path / shoulder-blend path); opens as a thin pill → body
expands downward → holds ~3s → collapses/exits. Light surface; title + icon in the status colour (success green, error
red, action blue, warning amber, info blue), body text muted. Variants: success, error, warning, info, action (body
with a "Confirm" button), loading (spinner pill only), promise (loading pill → morphs into "Upload Complete" with body),
custom. Positions: top-left/center/right, bottom-left/center/right. Animation presets: sileo, smooth, snappy, bouncy,
fluid, springEasing. Extra demos: Interactive Reply, Booking Multi-State, Tabs + ListView.
## Do
1. Replace the current `components/gooey_toast` + `primitives/gooey/**` implementation with a faithful port of main's
   behaviour, shapes, timing, presets and API, adapted to the new architecture rules (flat component folder:
   gooey_toast.dart / _style / user-owned _theme / preview / meta / README; reusable machinery in `primitives/gooey/`;
   files ≤ ~400 lines; widgets-only, NO Material/Cupertino; theme tokens via ThemedColor (status tones: keep main's
   colours as fixed tone defaults in the theme, user-overridable); density spacing; reduced motion; RTL). Keep the
   current public entry points working or document the clean-break API in README/meta. Delete dead code from the
   broken rewrite (incl. tests that pin the old behaviour — replace them).
2. Previews = the playground as named ComponentPreview examples: "Playground" (variant buttons + position + animation
   preset + show), one example per variant, "Promise", "Positions", "Animation presets", "Interactive Reply",
   "Booking Multi-State", "Tabs + ListView". Toasts render at the window/app edge (docs app-level host), never inside
   the stage over the trigger; nothing shows before a click.
3. Docs: ensure the docs app hosts the toast overlay app-wide so positions are relative to the browser window.
## Tests
Lifecycle with fake time (pill → expanding → expanded → collapse → removed, ~3s hold, hover pause), each variant's
title/icon colours, action button callback, promise loading→success morph, positions (rect near the right window edge),
presets produce different curves/durations, single merged silhouette path (no double stroke), reduced motion, no toast
before trigger.
## Gates
`cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, format/analyze/
test, `flutter build web --release`. Captures with agent-browser of OUR build matching each main capture (success
sequence, error, action, promise) → `rearch/design/ours/screens/p7g2-*.png` and a side-by-side note in the report.
Report `rearch/reports/P7-G2.md`, `## RESULT`. Append progress as you go. No git ops.
