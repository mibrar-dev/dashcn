# P7-FOCUS — web-only exception on every docs page (focus traversal hits an un-laid-out box)

## Symptom (orchestrator, release + profile web builds, every route incl. `/`, `/themes`, component pages)
When the browser window gains focus the console logs:
```
Bad state: RenderBox was not laid out: RenderSemanticsAnnotations#ed3e1
  at RenderSemanticsAnnotations.get$size / get$semanticBounds
  at FocusNode.get$rect
  at ReadingOrderTraversalPolicy_sort / sortDescendants
  at FocusTraversalPolicy__sortAllDescendants
  at ReadingOrderTraversalPolicy._findInitialFocus
  at _ViewState.didChangeViewFocus
```
So some focusable widget (a `Focus`/`FocusableActionDetector`/`Semantics`-wrapped control) is attached to the focus
tree while its render box is never laid out — e.g. a subtree kept mounted but skipped by layout (custom render object
that doesn't lay out a child, a snapshot/cached-image theme-switch layer, an overlay entry kept alive offstage, a
deferred or hidden header/palette/drawer/toast host, the always-mounted DrawerBackgroundScale wrappers, etc.).
Widget tests pass because `didChangeViewFocus` doesn't fire there.

## Task
1. Reproduce in a test: pump `DocsApp` (as docs/test does), then call the view-focus path
   (e.g. `tester.binding.platformDispatcher.onViewFocusChange` / `WidgetsBinding.instance.handleViewFocusChanged(
   ViewFocusEvent(viewId: …, state: ViewFocusState.focused, direction: ViewFocusDirection.forward))`, or
   `FocusManager.instance.rootScope` + `ReadingOrderTraversalPolicy().findFirstFocus(...)`) and assert no exception.
   Also cover the landing page, `/themes` and a component page. The test must FAIL before the fix.
2. Find the culprit (bisect: walk `FocusManager.instance.rootScope.descendants`, report each node's context widget and
   whether its renderObject `hasSize`). Fix the ROOT CAUSE in the owning widget (registry source → then
   `bash docs/tool/sync_registry.sh`, or docs/lib if it is docs-only): e.g. exclude the subtree from focus
   (`ExcludeFocus`/`canRequestFocus: false`/`descendantsAreFocusable: false`) while it is hidden, or make sure it is laid
   out. Don't wrap the whole app in a try/catch or a custom traversal policy.
3. Check with `git stash`-free reasoning whether this predates P7 (say so in the report; no git ops).

## Gates
`bash rearch/qa_gate.sh`; kit `flutter test test/registry`; docs `dart format --output=none --set-exit-if-changed lib test
tool`, `flutter analyze`, `flutter test`, `dart run tool/gen_docs_data.dart --check`, `bash tool/sync_registry.sh --check`,
`flutter build web --release`.

Report `rearch/reports/P7-FOCUS.md` with `## RESULT` (culprit widget/file, fix, test). No git ops. Do NOT open PNGs.
