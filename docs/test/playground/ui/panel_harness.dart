// Shared pump helper for `PlaygroundPanel` widget tests (not a test itself).
//
// Pumps the panel inside the real app shell (`DashcnApp` + the neutral site
// theme, so text has production colours) with a scroller mimicking the docs
// article. Fixed pump counts only — never `pumpAndSettle`, so a preview with
// a looping animation cannot hang the suite.

import 'package:docs/generated/app_theme.dart';
import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/ui/dashcn/components/app/app.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [PlaygroundPanel] for [componentId] at [viewport].
///
/// Query commits append to [queryLog] when given. Returns silently when the
/// component has no builder (the panel renders nothing).
Future<void> pumpPanel(
  WidgetTester tester,
  String componentId, {
  Size viewport = const Size(1280, 900),
  Brightness brightness = Brightness.light,
  Map<String, String>? initialQuery,
  List<Map<String, String>>? queryLog,
}) async {
  tester.view.physicalSize = viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final ThemeData light = buildDocsTheme('neutral', Brightness.light);
  final ThemeData dark = buildDocsTheme('neutral', Brightness.dark);
  await tester.pumpWidget(
    DashcnApp(
      theme: light,
      darkTheme: dark,
      themeMode: brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          key: const ValueKey<String>('panel-scroll'),
          child: SizedBox(
            width: viewport.width,
            child: PlaygroundPanel(
              componentId: componentId,
              initialQuery: initialQuery,
              onQueryChanged: queryLog == null
                  ? null
                  : (Map<String, String> query) => queryLog.add(query),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

/// Advances [frames] frames of 100 ms (lets popups and sheets land without
/// hanging on looping animations).
Future<void> pumpPanels(WidgetTester tester, [int frames = 4]) async {
  for (int i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Fails when the last pump left any error behind (layout overflows and
/// missing-ancestor errors surface here), draining the queue first.
void expectNoPanelErrors(WidgetTester tester, String label) {
  final List<String> errors = <String>[];
  Object? error = tester.takeException();
  while (error != null) {
    errors.add('$error');
    error = tester.takeException();
  }
  expect(errors, isEmpty, reason: label);
}

/// Scrolls [finder] into view (stacked layouts overflow the viewport).
Future<void> reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.descendant(
      of: find.byKey(const ValueKey<String>('panel-scroll')),
      matching: find.byWidgetPredicate(
        (Widget widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    ),
  );
  await tester.pump();
}
