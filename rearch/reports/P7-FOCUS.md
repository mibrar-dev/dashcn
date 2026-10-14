# P7-FOCUS — web-only `RenderBox was not laid out` on window focus

## Symptom
Release + profile web builds log on every route (including `/`, `/themes`,
component pages) when the browser window gains focus:
`Bad state: RenderBox was not laid out: RenderSemanticsAnnotations` via
`FocusNode.rect` → `ReadingOrderTraversalPolicy.sort` →
`_findInitialFocus` → `_ViewState.didChangeViewFocus`. Widget tests pass
because the engine never dispatches view-focus there.

## Bisect (instrumented debug web build, temporary logging, since reverted)
Added a temporary `WidgetsBindingObserver.didChangeViewFocus` dump in
`docs/lib/main.dart`, built debug web, reloaded under `agent-browser`:
- On the focus event: `total=228 badTotal=228` — **every** focus node in
  `rootScope.descendants` was un-laid-out (`NEEDS-LAYOUT`), including the
  header anchor (`header-focus-anchor`), header buttons and ~87 collage
  `Clickable`s. First offender shapes: `Focus` under `FocusableActionDetector`
  / `GestureDetector`, all with `RenderSemanticsAnnotations` parents.
- 3 s later (`LATE`): `total=238 badTotal=0` — everything laid out.
- After settle, `window.blur()` + `window.focus()` produced no new errors.

Conclusion: not one permanently hidden widget — a startup race. The engine
delivers the initial view-focus event after the tree is built but before the
first layout pass completes; the traversal reads all 228 rects and throws on
the first. No single-widget `ExcludeFocus`/`Offstage` fix can cover this;
the gate must span the whole app.

A docs-only gate (wrapping `home` in `main.dart`) was prototyped and
rejected: `EyeDropperLayer`'s session `Focus` lives in `ShadcnApp._buildApp`
*above* the docs builder, still traversable and un-laid-out pre-frame, so the
throw would survive. The gate belongs in the registry app shell, below the
`View` scope and above everything (including `EyeDropperLayer`).

## Fix
`flutter_shadcn_kit/lib/registry/components/app/app.dart` (+399 lines total):
new `_FirstFrameFocusGate` (stateful, `ExcludeFocus` until the first
post-frame, then opens; one extra startup frame) wrapping the whole
`_buildApp` chain outermost in `OverlayManagerLayer` position. Mirror
regenerated with `bash docs/tool/sync_registry.sh`
(`docs/lib/ui/shadcn/components/app/app.dart` identical). No try/catch, no
custom traversal policy; Tab order, shortcuts and the header anchor contract
are unchanged after settle.

## Tests
- `flutter_shadcn_kit/test/registry/components/app_focus_gate_test.dart`
  (new): after one pump no leaf focusable exists; after settle focusables
  exist.
- `docs/test/view_focus_test.dart` (new): startup gate invariant on the
  landing page + the exact view-focus path
  (`ReadingOrderTraversalPolicy().findFirstFocus` +
  `handleViewFocusChanged`) on landing, `/themes` and
  `/docs/components/button`.
- Pre-fix proof: with the gate forced open (`excluding: false`) the docs
  startup test fails; with the fix all pass. Widget tests cannot reproduce
  the engine's pre-first-frame dispatch (`attachRootWidget` does not inflate
  the tree), so the tests pin the gate invariant and exercise the path.

## Predates P7?
Yes in mechanism (reasoned without git stash; only `git log/status` used).
`ShadcnApp`, its focusables and the engine's initial-focus timing all date
to the P6 docs build; P7 only widened exposure (larger collage, Studio
canvas, more startup focusables). Any P6 web build with a slow first frame
could hit the same race.

## Gates
- `bash rearch/qa_gate.sh`: PENDING
- kit `flutter test test/registry`: PENDING (via qa_gate)
- docs format / analyze / test / gen --check / sync --check: PENDING
- `flutter build web --release`: PENDING (+ browser console re-check)

## RESULT
status: partial
files_written:
- /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/components/app/app.dart
- /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/docs/lib/ui/shadcn/components/app/app.dart
- /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/test/registry/components/app_focus_gate_test.dart
- /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/docs/test/view_focus_test.dart
- /Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/rearch/reports/P7-FOCUS.md
commands_run: []
key_findings: []
open_questions: []
