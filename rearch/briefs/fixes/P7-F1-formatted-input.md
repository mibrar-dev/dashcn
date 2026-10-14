# Brief P7-F1 — FormattedInput typing is broken (user report 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit.
Do NOT open PNG images yourself. Files: `lib/registry/components/formatted_input/**` and the segmented-text primitive it
uses (`SegmentedTextController`, grep `primitives/`), plus `phone_input`/`input_otp`/date-like users if they share it.

User: typing into a formatted input (e.g. phone `(555) 123-4567`): typing "555" shows only "5"; typing "52" shows 5 then
the 5 is replaced by 2; it never completes/advances to the next field.

Suspected root causes (verify, then fix at the root):
1. `_setValue` calls `_segments.setValues(..., notify:false)` after every keystroke, rewriting the controller the user is
   typing in — this can reset the selection/caret (and fight the IME). Never write back into the focused segment's
   controller when its text already equals the new value; when a write is needed, preserve the selection (clamp).
2. Segments use fixed widths (e.g. `width: 32` for 3 digits) too narrow for `length` glyphs at the current text style,
   so earlier characters scroll out of view (looks like replacement). Width must be computed from `length` × the max
   glyph advance of the resolved text style (TextPainter; tabular figures) + cursor, density-aware; `width` param only
   as an explicit override, never smaller than the content needs.
3. Expected behaviour (shadcn/OTP-like segmented field): typing appends; when a segment reaches `length` focus moves to
   the next segment with the caret at its start; Backspace in an empty segment moves to the previous segment's end and
   deletes there; ArrowLeft/Right cross segment boundaries at the edges; paste distributes characters across segments
   (respecting formatters); selection/IME composing works; controlled (`value` + `onChanged` setState) and uncontrolled
   modes both behave the same.
Tests (widget tests with real typing via `tester.enterText`/`sendKeyEvent` and `tester.testTextInput`): type "5551234567"
into the phone example → value `(555) 123-4567`, all three segments filled, focus advanced; "52" → "52"; caret offset
after each keystroke == text length; backspace across segments; paste; controlled + uncontrolled; each preview example.
Update preview examples if their widths were the cause. Gates: `cd $KIT && rearch/qa_gate.sh`; generators --check;
docs sync + --check, codegen --check, docs analyze/test. Report `rearch/reports/P7-F1.md`, `## RESULT`. No git ops.
