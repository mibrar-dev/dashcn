# Brief P7-CP1 — color picker eye dropper samples the WHOLE app, live (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself.
User: when I pick the eye-drop tool I should be able to move it over the whole website and the color picker should
react to it live — both the hue/alpha sliders and the saturation/value square.
## Do (registry `eye_dropper`, `color_picker`, colour primitives; the `app` component if a root boundary is needed)
1. Whole-app sampling: activating the dropper captures the app's root (a RepaintBoundary provided by `ShadcnApp` /
   an `EyeDropperScope` at the app root — install it in the registry app component and in the docs app) to an image
   (refresh the capture when the pointer moves onto newly painted content / on a short throttle), shows a loupe/
   magnifier + crosshair following the pointer across the ENTIRE window (overlay above everything, including the
   picker popover), reads the pixel under the pointer, and LIVE-updates the colour picker (SV square thumb, hue slider,
   alpha slider, hex/inputs, preview swatch) while moving. Click/tap commits; Escape or right-click cancels and restores
   the previous colour. Keyboard: arrows nudge 1px, Enter commits. Works in light/dark, with HiDPI (devicePixelRatio)
   correct pixel mapping, and on web + desktop. On platforms where capture is impossible, the button is hidden.
2. Fix any picker state issues found (the picker must reflect an external colour change immediately in every control).
3. Preview: "Eye dropper" example in color_picker (and eye_dropper's own preview if listed) — interactive.
Tests: with a known painted scene, moving the dropper to a pixel updates the picker value (hue/sat/val/alpha + hex) live;
commit vs cancel; DPR 2 mapping; overlay covers the full window; no exceptions after dispose (the old
"ValueNotifier used after dispose" bug must stay fixed).
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web --release. Report `rearch/reports/P7-CP1.md`, `## RESULT`. No git ops. Other agents may be
active (P7-Z2 stabilisation, P7-TH1 theming) — touch only colour/eye-dropper/app-root files.
