# Brief P7-I1 — date/time/object triggers: icon alignment + content-sized width (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit.
Do NOT open PNGs yourself (model crashes on images). Evidence (real release build, described):
`rearch/design/ours/screens/user-bugs-2026-10-11b/{date-range-card,time-card}.png`.
1. The leading calendar/clock icon in date_picker / date range / time_picker / object_input triggers sits ~6–8px LOWER
   than the label text in the browser (in widget tests the centres match, so the cause is the zero-height
   `_adornment` wrapper in `primitives/form_core/object_form_field.dart` + glyph metrics on web). Fix at the root:
   icon and label in one Row with crossAxisAlignment.center, the icon in a fixed `SizedBox.square(iconSize)` that is
   ≤ the line height, so it can't grow the trigger past h-9; verify centres equal (±1px) in light/dark, all densities,
   and with a web-like font (test with the docs' real font).
2. Width must be DYNAMIC: no hard-coded min widths (`triggerMinWidth` 240/140 etc.) and NEVER ellipsize the label — the
   trigger hugs `icon + gap + full label + padding` (a long range like "January 1, 2026 - January 14, 2026" shows in
   full); only a tight parent constraint may limit it (then wrap/scroll is NOT allowed — instead the label fits because
   the parent gave room, or the component reports overflow in debug). Empty-state placeholder sets the width when no
   value. Same rule for object_input and formatted triggers.
3. Update previews/blocks/home cards that relied on the min width.
Tests: icon/label vertical centres equal; trigger width == content width for short/long values; no ellipsis.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check, analyze/
test, build web. Report `rearch/reports/P7-I1.md`, `## RESULT`. No git ops. Other agents active: P7-H1 (home/blocks),
P7-S1 (button states), P7-C2 (preview sweep) — touch only your files.
