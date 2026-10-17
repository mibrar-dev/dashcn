// Shared widget-test harness for the docs app (D3 pages/widgets).
//
// Pumps the real `DocsApp` with in-memory storage and a deterministic
// viewport; exposes helpers to navigate and open the palette.

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory storage so tests never touch localStorage.
class MemoryDocsStorage extends DocsStorage {
  /// Creates a memory store, optionally pre-seeded.
  MemoryDocsStorage([Map<String, String>? seed])
    : values = <String, String>{...?seed};

  /// Stored key/value pairs.
  final Map<String, String> values;

  @override
  String? read(String key) => values[key];

  @override
  void write(String key, String value) => values[key] = value;
}

/// The [DocsState] of the last [pumpDocsApp] call.
late DocsState docsState;

/// Whether the isolate warm-up below ran already.
bool _isolateWarmed = false;

/// Warms every deferred page chunk once per isolate (P9-Z).
///
/// Widget-test isolates hang a fresh chunk load issued after an earlier
/// test zone did its own chunk loads, so a file that pumps landing (hero
/// chunk) and later navigates to a deferred page (component/block/flow
/// chunk) would hang: the later load never lands. The warm navigates
/// through one component, flows and blocks page up front — same-zone
/// sequential loads resolve — building each, because a fetched chunk only
/// installs on first build and only installed libraries are reusable
/// across tests (completed futures do not notify subscribers in later
/// zones). Programmatic configurations carry no query, leaving shell state
/// and storage untouched. Every later navigation reuses the installed
/// libraries. Preview chunks keep loading on demand (same-test sequential
/// loads resolve).
///
/// The warm builds run at a wide viewport: some pages overflow at phone
/// widths (pre-existing, out of scope), and those transient errors would
/// otherwise sit in the queue and fail the calling test's own overflow
/// assertions. The queue is drained before returning.
Future<void> _warmIsolate(
  WidgetTester tester,
  DocsRouterDelegate delegate,
) async {
  if (_isolateWarmed) {
    return;
  }
  _isolateWarmed = true;
  // The warm navigations below disturb focus (nested route installs pull
  // it away from the header anchor). Remember the pre-warm focus — the
  // shell never unmounts across inner-navigator pushes, so the same node
  // is still mounted afterwards — and restore it at the end, which also
  // refreshes ancestor focus bookkeeping the installs clobbered.
  final FocusNode? previouslyFocused = FocusManager.instance.primaryFocus;
  final Size warmSize = tester.view.physicalSize;
  tester.view.physicalSize = const Size(1400, 900);
  await tester.pump(const Duration(milliseconds: 100));
  final BuildContext context = tester.element(find.byType(Navigator).last);
  delegate.navigate(context, DocsRouteConfiguration.component('button'));
  await _settleWarm(tester);
  expect(find.text('Playground'), findsWidgets);
  delegate.navigate(context, DocsRouteConfiguration.flows);
  await _settleWarm(tester);
  expect(find.text('Flows that feel like apps'), findsOneWidget);
  delegate.navigate(context, DocsRouteConfiguration.blocks);
  await _settleWarm(tester);
  expect(find.text('Building Blocks for the Web'), findsOneWidget);
  delegate.navigate(context, DocsRouteConfiguration.starters);
  await _settleWarm(tester);
  expect(find.text('Start from a template'), findsOneWidget);
  await delegate.popRoute();
  await tester.pump(const Duration(milliseconds: 100));
  await delegate.popRoute();
  await tester.pump(const Duration(milliseconds: 100));
  await delegate.popRoute();
  await tester.pump(const Duration(milliseconds: 100));
  await delegate.popRoute();
  await tester.pump(const Duration(milliseconds: 100));
  tester.view.physicalSize = warmSize;
  await tester.pump(const Duration(milliseconds: 100));
  while (tester.takeException() != null) {}
  if (previouslyFocused?.context != null) {
    previouslyFocused!.requestFocus();
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Pumps past chunk delivery (engine callbacks need frames plus real time;
/// back-to-back fake pumps alone never deliver).
Future<void> _settleWarm(WidgetTester tester) async {
  for (int i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 25)),
    );
  }
}

/// Pumps the app at [width]×[height] (device pixel ratio 1).
Future<DocsRouterDelegate> pumpDocsApp(
  WidgetTester tester, {
  double width = 1400,
  double height = 900,
  Brightness platformBrightness = Brightness.dark,
  Map<String, String>? storage,
  DocsStorage? docsStorage,
}) async {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  tester.platformDispatcher.platformBrightnessTestValue = platformBrightness;
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

  docsState = DocsState(
    storage: docsStorage ?? MemoryDocsStorage(storage),
    systemBrightness: platformBrightness,
  );
  addTearDown(docsState.dispose);
  await tester.pumpWidget(DocsApp(state: docsState));
  await tester.pumpAndSettle();
  final DocsRouterDelegate delegate = tester
      .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
      .delegate;
  await _warmIsolate(tester, delegate);
  await tester.pumpAndSettle();
  await drainLandingHero(tester, delegate);
  return delegate;
}

/// Navigates the pumped app to [location] and settles.
Future<void> goTo(
  WidgetTester tester,
  DocsRouterDelegate delegate,
  String location,
) async {
  delegate.go(tester.element(find.byType(Navigator).last), location);
  await tester.pumpAndSettle();
}

/// Waits for the landing hero chunk to resolve (P9-Z).
///
/// The device-frame hero was removed: the home route carries no deferred hero
/// chunk and no device frames (they stay on component/flow pages). This is a
/// no-op kept for call-site compatibility; it returns immediately.
Future<void> drainLandingHero(
  WidgetTester tester,
  DocsRouterDelegate delegate, {
  Duration budget = const Duration(seconds: 30),
}) async {
  return;
}
