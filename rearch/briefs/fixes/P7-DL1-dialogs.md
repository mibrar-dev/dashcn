# Brief P7-DL1 — dialogs are centred and content-sized; fix dialog spacing (user 2026-10-11)

KIT=/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit, APP=$KIT/flutter_shadcn_kit, DOCS=$KIT/docs.
Do NOT open PNGs yourself. Evidence (described): `rearch/design/ours/screens/user-bugs-2026-10-11b/date-dialog-spacing.*`
— the date-picker dialog: a big empty band between the "March 2024" header row and the weekday row, extra empty space
under the day grid before the footer divider, and a focus ring drawn around an OUT-OF-MONTH day ("26") on open.
User: whenever a dialog opens it must NOT take the full width/height of the screen — it's centred, so it sizes to its
content (shadcn DialogContent: max-w-lg (512) default, w-full only up to that, p-6, gap-4, rounded-lg, centred both
axes, max-height = viewport − margins with internal scroll for long content). Check every dialog for spacing issues.
## Do (registry `dialog`, `alert_dialog`, `date_picker`/`time_picker` dialog variants, `object_form_prompt`, drawer/sheet
## excluded — they are edge-anchored by design)
1. Dialog route/surface: content-sized, centred, `maxWidth` from theme (default 512, `size` variants sm/md/lg), margin
   16px on mobile, never stretched to the screen; height hugs content up to viewport−2×margin then scrolls inside;
   header/body/footer gaps from theme spacing (gap-4), footer buttons right-aligned gap-2 (stack on mobile).
2. Date picker dialog: remove the extra band under the header and under the grid (calendar p-3, caption row h-9 with
   nav buttons, weekday row immediately below, grid rows size-8 × density), footer separated by one divider with p-3;
   initial focus goes to the SELECTED day (or today if in the month), never an out-of-month day, and the focus ring only
   shows for keyboard focus. Same audit for time picker + range picker dialogs.
3. Audit every `show*Dialog` usage in previews/blocks/docs (alert dialog, dialog examples, get-code dialog, command
   dialog, object prompts) for full-screen/stretched sizing and spacing; fix.
Tests: dialog rect is centred and ≤ maxWidth at 1440 and fits with margins at 375; height hugs content; date dialog: no
gap > theme gap between header/weekdays/grid/footer; initial focus on selected day, no ring without keyboard.
Gates: `cd $KIT && rearch/qa_gate.sh`; generators regenerate + --check; docs sync + --check, codegen --check,
analyze/test, build web --release. Captures (agent-browser) of alert dialog, dialog, date & time picker dialogs at 1440 +
375 → `rearch/design/ours/screens/p7dl1-*.png`. Report `rearch/reports/P7-DL1.md`, `## RESULT`. No git ops. Other agents
active: P7-CP1 (colour picker/eye dropper), P7-Z2 (stabilise), P7-TH1 (theming, starts after Z2) — touch only dialog files.
