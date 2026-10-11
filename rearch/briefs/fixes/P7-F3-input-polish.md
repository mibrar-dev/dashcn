# Brief P7-F3 — input polish after P7-F2 (orchestrator visual QA of p7f2 captures)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit.
Context: `rearch/reports/P7-F1.md`, `rearch/reports/P7-F2.md` (the previous fixes). Do NOT open PNGs yourself.
1. REGRESSION object_input: the "MM" segment is now too narrow and wraps onto two lines ("M" over "M") in
   `/docs/components/object_input`. Segments must never wrap: maxLines 1, no softWrap, width ≥ measured width of the
   placeholder AND of `length` max-advance glyphs at the resolved style. Test: every segment's text is one line.
2. formatted_input shows "(555 ) 123 -4567": each editable segment is wider than its digits and text is centred, so
   gaps appear before the static separators. Width = exact measured width of the content (`length` × max digit
   advance with tabular figures, or the placeholder, whichever is wider) + caret allowance only, and text aligned so
   segments butt against the static parts exactly like a single text field reads "(555) 123-4567". Test: gap between
   a segment's last glyph and the next static part ≤ 1px.
3. date_picker / time_picker / object_input triggers are ~52px tall; inputs are h-9 (36px × density). Match the input
   height token exactly (padding py from density). Test heights at all three densities.
4. gooey_toast: the status icon tint differs between modes (success = blue in dark, orange in light) because tones map
   to chart tokens. Use one stable semantic mapping per tone across modes/presets: success = a green from the
   theme if a `success` token exists, else a fixed accessible green blended with foreground for contrast; error =
   destructive; warning = amber; info = blue — consistent light/dark, contrast ≥ 3:1 on the toast surface. Test.
5. Split files > ~400 lines you touch (formatted_input.dart is 629).
Gates: `cd $KIT && rearch/qa_gate.sh`; generators --check (regenerate); docs sync + --check, codegen --check,
format/analyze/test, `flutter build web --release`. Captures → `rearch/design/ours/screens/p7f3-*.png` (object_input,
formatted_input, date_picker, time_picker at 1440 dark; gooey toast expanded light + dark). Report
`rearch/reports/P7-F3.md`, `## RESULT`. No git ops.
