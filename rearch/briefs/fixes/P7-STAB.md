# P7-STAB — stabilise the P7 batch (make every suite green)

All P7 agents (TH1, CP1, DL1, NM1, WA, WB, WC, WC2, BF1, WD, TS1, I1, H1, S1, B2, Z2, C2) have finished and the tree
is now quiet. These suites currently fail. Fix each one by finding its ROOT CAUSE first:
- if the product behaviour is right and the test encodes OLD behaviour (e.g. toasts now open over the whole app via
  a trigger button instead of rendering inline; dialog/alert previews now show a trigger and open centred, content-sized
  dialogs; navigation menu was redesigned like shadcn; preview example names changed), update the test to assert the
  NEW behaviour (open the overlay through the trigger, then assert). Do not delete coverage.
- if the product is broken, fix the product (registry source under flutter_shadcn_kit/lib/registry, then
  `bash docs/tool/sync_registry.sh`), never the test.

## Failing — kit (`cd flutter_shadcn_kit && flutter test test/registry`) — 9
- test/registry/qa/alert_dialog_qa_test.dart: live push opens, returns a result and pops (assertion at :129)
- test/registry/qa/toast_qa_test.dart: Default / Destructive / With action previews (text not found — toasts are app-wide now)
- test/registry/qa/gooey_toast_qa_test.dart: the playground examples are discoverable by name (example names list)
- test/registry/qa/interactive_previews_test.dart: alert_dialog frame confirms/cancels (StateError: example name),
  dialog trigger pushes a dialog (_tap finds nothing), navigation_menu plain item reports the page (example name),
  toast inline action dismisses and reports (+ the remaining ones in the run)

## Failing — docs (`cd docs && flutter test`) — 7
- test/component_examples_test.dart: "no overflow at 375 and 1440" — REAL BUG: `RenderFlex children have non-zero flex
  but incoming height constraints are unbounded` in a Column ← LayoutBuilder ← Column ← DocsArticleScope inside the
  article scroll view. Find which component page/preview causes it (bisect by component id) and fix the layout
  (Expanded inside an unbounded Column → Flexible/loose or give a bounded height).
- component_examples_test.dart: "D1b: example stage centres content at 1440 and 375", "D1b: toolbar stays single row at
  320 and 375", "P7-Z: toolbar pins tabs left and actions right" — probably the same crash cascading; re-check after the fix.
- the other 3 docs failures in the run (run the suite to list them; likely home_collage / themes_page / ts1_*).

Also delete the scratch file `docs/test/ts1_captures_test.dart` if it reappears; do not create capture tests.

## Gates (all must pass, paste the summary lines in the report)
`bash rearch/qa_gate.sh`; kit `flutter test test/registry` and `flutter test test/rearch`; generators `--check`
(manifest, previews test, blocks test); docs: `dart format --output=none --set-exit-if-changed lib test tool`,
`flutter analyze`, `flutter test`, `dart run tool/gen_docs_data.dart --check`, `bash tool/sync_registry.sh --check`,
`flutter build web --release`.

Report: `rearch/reports/P7-STAB.md` with `## RESULT` (each failure: cause, fix, file). No git ops. Do NOT open PNG images.
