# Brief P7-D2b — preview canvas: blurred, NOT grey (user feedback)

Context: `rearch/reports/P7-D2.md` (your previous change). User: "the background should be blurred, not grayed".
Do NOT open PNGs yourself.
- Remove the grey canvas fill: the preview canvas keeps the ORIGINAL surface (page/background token, as before P7-D2).
- Keep the dot pattern but blurred/soft (low alpha, ImageFilter.blur on the pattern layer only) so it reads as a
  subtle frosted texture; the component content stays sharp and on top.
- Components must still separate from the canvas through their own border/shadow tokens — do not tint the canvas.
Tests: canvas fill == background token (light/dark, neutral + claude); pattern layer blurred; content not blurred.
Gates: docs format/analyze/test/codegen --check/sync --check/build web --release. Re-capture p7d2-* (card, button,
select at 1440 light + dark) as `p7d2b-*.png`; update `rearch/reports/P7-D2.md` with a D2b section + `## RESULT`. No git.
