// Regression (user report 2026-10-11): on the home page, "Danger zone" →
// "Delete project" → "Delete" popped the docs page navigator instead of the
// alert, leaving it empty (`_history.isNotEmpty` assertion in debug).
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  for (final String action in <String>['Delete', 'Cancel']) {
    testWidgets('Danger zone alert "$action" closes only the alert', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 1400, height: 2400);
      final Finder open = find.text('Delete project');
      await ensureVisibleBelowHeader(tester, open);
      await tester.tap(open);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Delete this project?'), findsOneWidget);

      await tester.tap(find.text(action).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.takeException(), isNull);
      expect(find.text('Delete this project?'), findsNothing);
      expect(find.text('Delete project'), findsOneWidget);
    });
  }
}
