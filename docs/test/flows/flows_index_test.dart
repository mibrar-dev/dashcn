// P9-3b index tests: `/docs/flows` lists every flow from the manifest.
//
// Counts are derived from `kFlows` (generated facts), never hard-coded.

import 'package:docs/generated/docs_flows.dart';
import 'package:docs/pages/flows_pages.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_strings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  group('flows index', () {
    testWidgets('one card per flow from the manifest', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/flows');
      expect(find.text('Flows that feel like apps'), findsOneWidget);
      expect(find.byType(FlowCard), findsNWidgets(kFlows.length));
      for (final DocsFlow flow in kFlows) {
        expect(find.text(flow.name), findsWidgets, reason: flow.id);
        expect(find.text(flow.description), findsOneWidget, reason: flow.id);
        expect(
          find.text('${flow.screens.length} screens'),
          findsWidgets,
          reason: flow.id,
        );
        expect(find.text(flow.install), findsWidgets, reason: flow.id);
      }
    });

    testWidgets('every flow page opens from its card', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/flows');
      for (final DocsFlow flow in kFlows) {
        await goTo(tester, delegate, '/docs/flows/${flow.id}');
        expect(find.byType(FlowPage), findsOneWidget, reason: flow.id);
        expect(find.text(flow.name), findsOneWidget, reason: flow.id);
      }
    });

    testWidgets('unknown flow id shows the missing page', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/flows/nope-01');
      expect(
        find.text('No flow named `nope-01`.', skipOffstage: false),
        findsOneWidget,
      );
    });

    test('screen count uses English singular and plural', () {
      expect(docsFlowScreensCount(1, const Locale('en')), '1 screen');
      expect(docsFlowScreensCount(4, const Locale('en')), '4 screens');
      expect(docsFlowScreensCount(0, const Locale('en')), '0 screens');
    });

    test('screen count uses German singular and plural', () {
      expect(docsFlowScreensCount(1, const Locale('de')), '1 Screen');
      expect(docsFlowScreensCount(4, const Locale('de')), '4 Screens');
    });

    testWidgets('German locale renders the German screen count', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      docsState.setLocale(const Locale('de'));
      await tester.pumpAndSettle();
      await goTo(tester, delegate, '/docs/flows');
      // `auth-01` has 4 screens; the German badge keeps the German noun.
      expect(find.text('4 Screens'), findsWidgets);
      expect(find.text('4 screens'), findsNothing);
      expect(find.text('1 Screen'), findsNothing);
    });
  });
}
