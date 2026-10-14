# Brief P7-G3 — make the gooey toast look EXACTLY like main's (user: "still not looking the same")

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Context: `rearch/reports/P7-G2.md` (the port). Do NOT open PNGs yourself; orchestrator side-by-side:
`rearch/design/main-ref/gooey-toast/main-vs-ours.png` (described below). Source of truth = main's code:
`git show origin/main:flutter_shadcn_kit/lib/registry/components/overlay/gooey_toast/_impl/core/gooey_toast_widget.dart`
(`_buildGooeyShapePath`, `_buildGooeyBodyPath`, `_buildGooeyShoulderBlendPath`, sizes/radii/constants in
`gooey_toast_constants.dart`, colours in `_impl/themes/**` and `gooey_toast_defaults.dart`). Copy the numbers, don't
re-derive them. Live: https://mibrar-dev.github.io/shadcn_flutter_kit/#/components/gooey_toast (canvas; click by coords).

## Differences to remove (main → ours)
1. SURFACE: main = light near-white fill (≈ #F7F8FA) with NO border/outline in BOTH light and dark site modes; ours = dark
   fill + 1px border in dark. Use main's surface colours as the theme defaults (user-overridable via the component
   theme); no stroke.
2. SHAPE: main's pill sits on the body with SHORT, TIGHT concave fillets (small radius, pill sides nearly vertical);
   ours has long sloping "wing" shoulders spreading across the body. Port main's exact path math + constants (pill
   height/padding, body radius ≈16, fillet radius, shoulder blend) — same silhouette at every stage of the morph.
3. ACTION variant: main shows a "Confirm" action button (soft tinted pill button, blue) inside the body under the
   description; ours shows none. Restore action rendering exactly.
4. CLOSE ×: REMOVE the close button entirely (user, 2026-10-11: "remove the close button") — no × widget, no
   `showClose`-style param, nothing in previews/README/meta. Toasts dismiss by timeout, swipe and tap-to-dismiss (if
   main has it) and the `dismiss` API.
5. TEXT: body description is muted grey on the light surface (main); title + icon in the status colour (green
   "Success", red "Error", blue "Action Required", amber warning, blue info); main's default titles per variant.
6. LOADING pill: light, like main.
7. Sizes: main body width ≈ 500px at 1440, pill ≈ 150px wide; match main's widths/paddings/typography sizes.
Keep: top-centre placement, lifecycle (pill → expand → hold ~3s → collapse), positions, presets, previews, reduced
motion, widgets-only, files ≤ ~400 lines.
## Verify
Build docs release, serve, and capture OUR success / error / action / loading toasts at 1440 dark with agent-browser
(trigger via the preview buttons), next to fresh captures of main's site for the same variants → numeric checks you CAN
do without viewing images: sample the surface colour at the body centre (must be light ≈ main's, in dark site mode),
measure the silhouette bounding boxes (pill w/h, body w/h) from the screenshots with PIL and compare to main (±4px),
check no border pixels. Put the numbers in the report. Tests: surface colour default, no stroke, action button present
for action variant, no close button exists, path geometry constants equal main's.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators --check; docs sync + --check, codegen --check, analyze/test, build web.
Report `rearch/reports/P7-G3.md`, `## RESULT`. No git ops. (Agent P7-T1 is fixing chip/pinned_sheet/tree tests — don't
touch those.)
