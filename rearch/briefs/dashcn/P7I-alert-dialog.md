# P7I-alert-dialog — alert dialog opens over the whole app and is properly spaced

Ibrar's request: "the alert dialog should also show over the whole app and it should also have the padding and spacing
issues resolved so it looks good. Currently it's so cramped up together that everything is touching the corners."

You work in `$KIT` (worktree `dashcn-kit-b`, branch `integrate/p7-into-dashcn`; a merge of `refactor/rearchitecture`
is in progress and fully resolved). Do NOT run git commands that change the index or HEAD. Read
`$KIT/rearch/plans/P7_INTEGRATION.md` and the P7I-kit-a report in `$KIT/rearch/reports/` (P7 moved dialog, drawer and
toast previews to app-wide root-navigator overlays; the alert dialog was left behind).

## What is wrong (orchestrator's browser check)
- `/docs/components/alert_dialog`: the main examples ("Delete account", "Discard changes", "Session expiring",
  "Success") render `AlertDialog(...)` INLINE in the preview stage (`dashcn/lib/src/components/alert_dialog/
  preview.dart`, ~lines 67 and 185, plus a "Show again" button). The card shell (padding 24, radius, border, shadow)
  comes from the dialog route (`DialogTheme`), so inline the content touches the card edges: the title sits on the top
  border, the icon and the actions touch the sides, and there is no breathing room between icon, title, description
  and footer. Only "Live push" opens over the app via `showAlertDialog`.

## Do
1. Every alert dialog example opens over the whole app, exactly like P7's dialog previews
   (`components/dialog/preview.dart`): a centred trigger button in the stage; pressing it calls `showAlertDialog`
   (root navigator, barrier, app-wide). Keep each example's content (icons, destructive/primary actions, the success
   variant, the session-expiring countdown if present). Example names stay (docs anchors and tests use them).
2. Spacing: compare with the upstream web reference (shadcn/ui v4 AlertDialog: content p-6, gap-4 between header and
   footer, header gap-2 between title and description, footer gap-2 between buttons, an optional media/icon with gap
   to the text). Make the dialog read well at default density in light and dark: nothing touches the card edge,
   consistent gaps, the icon aligned with the title's first line, actions right-aligned on wide, stacked full-width on
   narrow (<= 480 px). All values from theme spacing/radius tokens (no hard-coded pixels except where the theme has no
   token), honouring `AlertDialogTheme` overrides. If `AlertDialog` is used outside a dialog route (inline), it must
   still look right: give it the card shell (padding/radius/border/shadow from `DialogTheme`) unless it is already
   inside one. No double padding inside the route.
3. Update the README usage, `meta.json` if the API/description changes, and the QA/visual tests:
   `dashcn/test/registry/qa/alert_dialog_qa_test.dart`, `components/alert_dialog_test.dart` (or the existing alert
   dialog tests), the `previews_centered_test` generator if the stage content changes, and
   `test/registry/visual/p7wa_screens_test.dart` captures. Add a test that pumps an example, taps its trigger, and
   asserts the dialog is shown in the root overlay (over the whole app) with the title inset from the card edge
   (≥ 16 px at default density) and the footer gap > 0.
4. Captures for the orchestrator: write PNGs of the open dialogs (light + dark, 1280×900 and 390×844) to
   `$KIT/rearch/screenshots/p7i-alert-dialog/` with the background inside the RepaintBoundary.
5. Regenerate: in `$APP` every generator (`registry/gen_registry_manifest.dart`, `gen_exports.dart`,
   `registry/gen_previews_test.dart`, `registry/gen_blocks_test.dart`, `gen_scorecards.dart`); in `$DOCS`
   `bash tool/sync_registry.sh && dart run tool/gen_docs_data.dart`.
6. Gates: kit `bash ../rearch/qa_gate.sh` (from `$APP`), every generator `--check`, `dart run tool/check_names.dart`
   (0), `dart format --set-exit-if-changed .` in both packages; docs `flutter analyze` and `flutter test test tool`
   (run it in the background with a log under `$KIT/rearch/logs/` and poll it).

## Report
`$KIT/rearch/reports/P7I-alert-dialog.md`: what changed (files), the spacing values and where they come from, the
tests and captures, and the gate lines. End with `## RESULT` and `status: done` or `status: blocked`.
