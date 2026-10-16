// Page titles in the accessibility tree (live-qa #4).
//
// Root cause: the `drawer` (background-scale demo), `app` (`DashcnApp` /
// `WidgetsApp`), `overlay_configuration` (`AppLayer` + `Navigator`) and
// `page_route` previews each own a nested `Navigator`. Every `ModalRoute`
// inserts a `ModalBarrier` (`BlockSemantics`) overlay entry, which —
// without a semantics boundary — hides previously-painted siblings (the
// docs article title) from assistive tech. The landing hero (three flow
// `Navigator`s) did the same to its H1, and `/themes` had no heading at
// all. Fix: each nested preview is scoped in a `Semantics(container: true,
// explicitChildNodes: true)` boundary (`DeviceFrame`, `PreviewStage` and
// the kit previews), and page titles are marked `header: true`.

import 'package:docs/routing/docs_router.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

Future<void> _goTo(
  WidgetTester tester,
  DocsRouterDelegate delegate,
  String location,
) async {
  delegate.go(tester.element(find.byType(Navigator).first), location);
  for (int i = 0; i < 60; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.byType(Navigator).evaluate().isNotEmpty) {
      break;
    }
  }
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pumpAndSettle();
}

void main() {
  const Map<String, String> titles = <String, String>{
    '/docs/components/drawer': 'Drawer',
    '/docs/components/app': 'App',
    '/docs/components/overlay_configuration': 'Overlay Configuration',
    '/docs/components/page_route': 'Page Route',
    '/': 'Every platform at once',
    '/themes': 'Themes',
  };

  for (final MapEntry<String, String> entry in titles.entries) {
    testWidgets('semantics header "${entry.value}" at ${entry.key}', (
      tester,
    ) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _goTo(tester, delegate, entry.key);

      final Finder labelled = find.bySemanticsLabel(entry.value);
      expect(
        labelled,
        findsWidgets,
        reason: '${entry.key} must expose "${entry.value}" to semantics',
      );
      bool headerFound = false;
      final int count = labelled.evaluate().length;
      for (int i = 0; i < count; i++) {
        final SemanticsNode node = tester.getSemantics(labelled.at(i));
        if (node.flagsCollection.isHeader) {
          headerFound = true;
          break;
        }
      }
      expect(headerFound, isTrue, reason: '"${entry.value}" must be a header');
      handle.dispose();
    });
  }
}
