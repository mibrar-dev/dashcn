// Scorecards page tests (P9-5b): the "How we measure" page renders its
// explainer sections and the overview table (one row per scored component),
// sortable by failures.

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

  testWidgets('page renders explainer sections and a row per scorecard', (
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
    // Every user-facing component is scored (83 at P9-5b, 84 with
    // swipe_actions); the page must list all of them, whatever the count.
    expect(kScorecards, isNotEmpty);
    for (final String id in kScorecards.keys) {
      expect(
        find.byKey(ValueKey<String>('scorecard-row-$id')),
        findsOneWidget,
        reason: id,
      );
    }
    expect(find.text('Sort by failures'), findsOneWidget);
    expect(
      find.textContaining('${kScorecards.length} components'),
      findsOneWidget,
    );
  });

  testWidgets('sorting by failures keeps alphabetical order', (
    WidgetTester tester,
  ) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/scorecards');
    Offset topLeft(String id) =>
        tester.getTopLeft(find.byKey(ValueKey<String>('scorecard-row-$id')));
    // Alphabetical by default: accordion sits above chip.
    expect(topLeft('accordion').dy < topLeft('chip').dy, isTrue);
    await ensureVisibleBelowHeader(tester, find.text('Sort by failures'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sort by failures'));
    await tester.pumpAndSettle();
    expect(find.text('Sorted by failures'), findsOneWidget);
    // Every component passes, so the failure sort is a stable alphabetical
    // order: accordion still sits above chip.
    expect(topLeft('accordion').dy < topLeft('chip').dy, isTrue);
    // All rows survive the re-sort.
    for (final String id in kScorecards.keys) {
      expect(
        find.byKey(ValueKey<String>('scorecard-row-$id')),
        findsOneWidget,
        reason: id,
      );
    }
  });

  testWidgets('no checks are exempt; every row passes', (
    WidgetTester tester,
  ) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/scorecards');
    // Zero exemptions: decorative examples pass the semantics check
    // vacuously, so no check on any component carries an exempt entry.
    for (final String id in kScorecards.keys) {
      expect(kScorecards[id]!.failureCount, 0, reason: '$id failures');
      expect(kScorecards[id]!.exemptCount, 0, reason: '$id exempt');
    }
    expect(find.text('Exempt'), findsNothing);
    expect(find.text('0 failures'), findsNWidgets(kScorecards.length));
  });
}
