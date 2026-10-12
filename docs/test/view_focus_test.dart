// P7-FOCUS regression: the engine delivers the initial view-focus event
// before the first frame lays out. The view's reading-order traversal must
// not throw on un-laid-out boxes, so `ShadcnApp` keeps everything
// unfocusable until the first frame completes (`_FirstFrameFocusGate`).
// Covers the landing page, `/themes` and a component page.
//
// Widget tests cannot reproduce the engine's pre-first-frame dispatch
// (`attachRootWidget` does not inflate the tree, so there is no built-but-
// unlaid-out window); instead the startup test pins the gate invariant — no
// leaf focusable after the first pump, focusables after settle — and every
// test exercises the exact view-focus path on a settled tree. Without the
// gate the startup assertion fails.

import 'dart:ui';

import 'package:docs/main.dart';
import 'package:docs/state/docs_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

/// The view scope the framework's `_ViewState.didChangeViewFocus`
/// traverses with a `ReadingOrderTraversalPolicy`.
FocusScopeNode _viewScope() {
  return FocusManager.instance.rootScope.descendants
      .whereType<FocusScopeNode>()
      .firstWhere((FocusScopeNode scope) => scope.debugLabel == 'View Scope');
}

/// Whether any leaf (non-scope) focus node under the view scope can take
/// focus right now.
bool _hasLeafFocusable() {
  final FocusScopeNode scope = _viewScope();
  return scope.descendants.any(
    (FocusNode node) =>
        node is! FocusScopeNode &&
        node.canRequestFocus &&
        !node.skipTraversal &&
        node.context != null,
  );
}

/// Runs the exact view-focus path the engine fires when the browser window
/// gains focus: the synchronous policy traversal (throws on un-laid-out
/// boxes) plus the binding dispatch (which reports through `FlutterError`).
void _expectViewFocusClean(WidgetTester tester) {
  ReadingOrderTraversalPolicy().findFirstFocus(
    _viewScope(),
    ignoreCurrentFocus: true,
  );
  tester.binding.handleViewFocusChanged(
    ViewFocusEvent(
      viewId: tester.view.viewId,
      state: ViewFocusState.focused,
      direction: ViewFocusDirection.forward,
    ),
  );
}

void main() {
  testWidgets('startup: nothing is focusable before the first frame settles', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    docsState = DocsState(
      storage: MemoryDocsStorage(),
      systemBrightness: Brightness.dark,
    );
    addTearDown(docsState.dispose);

    // One frame: the tree is built and laid out, but the first-frame gate
    // is still closed (it opens in a post-frame callback).
    await tester.pumpWidget(DocsApp(state: docsState));
    expect(_hasLeafFocusable(), isFalse);
    _expectViewFocusClean(tester);

    await tester.pumpAndSettle();
    expect(find.text('A Flutter component kit you own'), findsOneWidget);
    expect(_hasLeafFocusable(), isTrue);
    _expectViewFocusClean(tester);
  });

  testWidgets('view focus is clean on /themes', (WidgetTester tester) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/themes');
    _expectViewFocusClean(tester);
  });

  testWidgets('view focus is clean on a component page', (
    WidgetTester tester,
  ) async {
    final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
    await goTo(tester, delegate, '/docs/components/button');
    _expectViewFocusClean(tester);
  });
}
