# Brief P7-F2 — date/time/object/formatted/phone inputs: take only the space they need (user report 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Builds on P7-F1 (`rearch/reports/P7-F1.md` — formatted input typing/segment widths); read it first. Do NOT open PNGs
yourself (model crashes on images); orchestrator evidence: `rearch/design/ours/screens/user-bugs-2026-10-11/input-widths.png`.
Reference: shadcn/ui date-picker (trigger `w-[240px] justify-start text-left font-normal` with the calendar icon on the
LEFT, `px-3`), input-otp / phone-input demos.

User: the phone field and object input are too wide; they should take only the space they need — same for date, time
and any other formatted input.

## Observed (fix all at the root, registry components)
1. date_picker + time_picker triggers stretch the full available width (~560px); the label text is flush against the
   left border (no horizontal padding) and the icon sits right after the text. → Trigger is a button-like control:
   intrinsic width (min ~240px for date, ~140px for time, grows to fit the label), padding px-3 (density), icon on the
   leading side with gap-2, muted placeholder; full width ONLY when the parent asks (e.g. `expand: true` or tight
   constraints in a form). 
2. object_input: wide box with uneven segment spacing ("MM /DD /YYYY") and a big empty right area. → Hug content:
   segments + separators with consistent gaps, trailing icon at the end with padding, intrinsic width.
3. formatted_input: separators render in the wrong positions — the phone example shows "555 (123 ) 4567" instead of
   "(555) 123-4567" — and the box has a large empty trailing area. → Static parts render exactly where declared;
   intrinsic width.
4. phone_input: country select and number field look like two loose boxes; make it one joined input group (shared
   border, divider between country trigger and field), intrinsic width sized to the number format.
5. General rule for these inputs: never stretch to the parent in loose constraints; respect tight constraints; density
   scaling; RTL; light/dark.
Tests: rendered width == intrinsic content width (± padding) under a 1000px loose parent; text has ≥ horizontal padding
from the border; icon position (leading for date/time); formatted text order matches the declared parts; phone group is
one bordered box. Update previews/blocks/docs usages that relied on stretching (pass `expand` where a full-width field
is intended, e.g. in forms).
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
format/analyze/test, `flutter build web --release`. Captures (agent-browser) of the five component pages at 1440 dark
→ `rearch/design/ours/screens/p7f2-*.png`. Report `rearch/reports/P7-F2.md`, `## RESULT`. No git ops.
