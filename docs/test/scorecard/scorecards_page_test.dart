// Scorecards page tests (P9-5b): the "How we measure" page renders its
// explainer sections and the 83-row overview table, sortable by failures.

import 'package:docs/generated/docs_scorecards.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  testWidgets('scorecards route parses and round-trips', (
    WidgetTester tester,
  ) async {
    expect(
      DocsRouteConfiguration.parse('/docs/scorecards'),
      DocsRouteConfiguration.scorecards,
    );
    expect(DocsRouteConfiguration.scorecards.location, '/docs/scorecards');
    expect(DocsRouteConfiguration.scorecards.title, 'How we measure');
  });

  testWidgets('page renders explainer sections and all 83 rows', (
    WidgetTester tester,
  ) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/scorecards');
    expect(find.text('How we measure'), findsWidgets);
    // Headings also appear in the "On This Page" TOC, so they match twice.
    expect(find.text('Metrics'), findsWidgets);
    expect(find.text('How it is produced'), findsWidgets);
    expect(find.text('Limits'), findsWidgets);
    expect(find.text('All components'), findsWidgets);
    expect(
      find.textContaining('dart run tool/gen_scorecards.dart'),
      findsWidgets,
    );
    expect(kScorecards.length, 83);
    for (final String id in kScorecards.keys) {
      expect(
        find.byKey(ValueKey<String>('scorecard-row-$id')),
        findsOneWidget,
        reason: id,
      );
    }
    expect(find.text('Sort by failures'), findsOneWidget);
    expect(find.textContaining('83 components'), findsOneWidget);
  });

  testWidgets('sorting by failures puts the worst component first', (
    WidgetTester tester,
  ) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/scorecards');
    Offset topLeft(String id) =>
        tester.getTopLeft(find.byKey(ValueKey<String>('scorecard-row-$id')));
    // Alphabetical by default: accordion sits above chip.
    expect(topLeft('accordion').dy < topLeft('chip').dy, isTrue);
    await tester.ensureVisible(find.text('Sort by failures'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sort by failures'));
    await tester.pumpAndSettle();
    expect(find.text('Sorted by failures'), findsOneWidget);
    // Chip (4 failures) is the alphabetical first among the worst.
    expect(topLeft('chip').dy < topLeft('accordion').dy, isTrue);
    // All rows survive the re-sort.
    for (final String id in kScorecards.keys) {
      expect(
        find.byKey(ValueKey<String>('scorecard-row-$id')),
        findsOneWidget,
        reason: id,
      );
    }
  });
}
