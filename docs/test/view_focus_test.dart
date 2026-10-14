// P7-FOCUS regression: the engine delivers the initial view-focus event
// before the first frame lays out. The view's reading-order traversal must
// not throw on un-laid-out boxes, so `DashcnApp` builds nothing until the
// first frame completes (`_FirstFrameFocusGate`). Covers the landing page,
// `/themes` and a component page.
//
// P7I-fix-focus2: an earlier revision hid the subtree behind
// `Focus(descendantsAreTraversable: false)`; in release web the first frame's
// nodes stayed untraversable (first Tab skipped the header). Building nothing
// keeps the protection and leaves every node traversable.
//
// Widget tests cannot reproduce the engine's pre-first-frame dispatch
// (`attachRootWidget` does not inflate the tree, so there is no built-but-
// unlaid-out window); instead the startup test pins the gate invariant — no
// leaf focusable after the first pump, focusables after settle — and every
// test exercises the exact view-focus path on a settled tree. Without the
// gate the startup assertion fails.

import 'dart:ui';

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/components/app/app.dart'
    show debugFirstFrameFocusGateOnAllPlatforms;
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
  // The gate is web-only in apps; force it here so the VM test exercises it.
  setUp(() => debugFirstFrameFocusGateOnAllPlatforms = true);
  tearDown(() => debugFirstFrameFocusGateOnAllPlatforms = false);

  // NOTE (P9-Z): the startup test runs LAST. It pumps `DocsApp` directly
  // (no harness warm), so its zone is the first in this isolate to issue a
  // deferred-chunk load; any later zone's fresh chunk load would never land
  // (see `support/app_harness.dart`). Running it last means every chunk is
  // already installed by the harness warm, and the direct pump reuses them.
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

    // One frame: nothing is built yet (the gate opens in a post-frame
    // callback, so the first content frame still has to run).
    await tester.pumpWidget(DocsApp(state: docsState));
    expect(_hasLeafFocusable(), isFalse);
    _expectViewFocusClean(tester);

    await tester.pumpAndSettle();
    // Drain the deferred landing hero chunk (P9-Z): an orphaned loadLibrary
    // at test end would poison the chunk loader for later tests sharing
    // this isolate (see `support/app_harness.dart`).
    final DocsRouterDelegate delegate = tester
        .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
        .delegate;
    await drainLandingHero(tester, delegate);
    await tester.pumpAndSettle();
    expect(find.text('Every platform at once'), findsOneWidget);
    expect(_hasLeafFocusable(), isTrue);
    _expectViewFocusClean(tester);
  });
}
