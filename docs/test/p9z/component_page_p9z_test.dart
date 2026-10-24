// P9-Z component page integration: frames + playground panel + scorecards
// dialog.
//
// The preview runs inside `FramedPreview` (router `?frame=` round-trip),
// the Playground opens as a right-side panel (Figma-like) seeding from
// `p.*` and reporting back through the router, and the trust scorecard
// opens from the top button in a dialog/sheet.

import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:docs/widgets/device_frame/framed_preview.dart';
import 'package:docs/widgets/scorecard/scorecard_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Pumps the component page for [id] at [width] and settles the deferred
/// chunks (mirrors `component_page_test.dart`).
Future<DocsRouterDelegate> pumpComponentPage(
  WidgetTester tester,
  String id, {
  double width = 1400,
  double height = 900,
  String query = '',
}) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(
    tester,
    width: width,
    height: height,
  );
  await goTo(tester, delegate, '/docs/components/$id$query');
  return delegate;
}

void main() {
  group('p9z component page', () {
    testWidgets('router round-trips ?frame=iphone&p.variant=outline', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpComponentPage(
        tester,
        'button',
        query: '?frame=iphone&p.variant=outline',
      );
      expect(docsState.frame, DeviceFrameId.iphone);
      expect(docsState.playgroundQuery['p.variant'], 'outline');

      final DocsRouteInformationParser parser = DocsRouteInformationParser(
        state: docsState,
      );
      final RouteInformation? reported = parser.restoreRouteInformation(
        delegate.currentConfiguration,
      );
      expect(reported, isNotNull);
      expect(reported!.uri.queryParameters['frame'], 'iphone');
      expect(reported.uri.queryParameters['p.variant'], 'outline');
    });

    testWidgets('reload (setNewRoutePath) applies frame and playground', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      final Uri uri = Uri.parse(
        '/docs/components/button?frame=android&p.size=sm',
      );
      await delegate.setNewRoutePath(
        DocsRouteConfiguration.parse(uri.toString()).withSourceUri(uri),
      );
      await tester.pumpAndSettle();
      expect(docsState.frame, DeviceFrameId.android);
      expect(docsState.playgroundQuery['p.size'], 'sm');
      expect(find.text('Button'), findsWidgets);
    });

    testWidgets(
      'button shows preview frames, playground panel and scorecards dialog',
      (WidgetTester tester) async {
        await pumpComponentPage(tester, 'button');
        expect(
          find.byWidgetPredicate(
            (Widget w) => w is FramedPreview && w.id == 'button',
          ),
          findsOneWidget,
        );
        // Top buttons open the panel/dialog instead of inline sections.
        expect(find.text('Playground'), findsWidgets);
        expect(find.text('Trust scorecards'), findsOneWidget);
        expect(find.byType(PlaygroundPanel), findsNothing);
        expect(find.byType(ScorecardCard), findsNothing);
        // Open the playground side panel.
        await tester.tap(find.text('Playground'));
        await tester.pumpAndSettle();
        expect(find.byType(PlaygroundPanel), findsOneWidget);
        // Open the scorecards dialog.
        await tester.tap(find.text('Trust scorecards'));
        await tester.pumpAndSettle();
        expect(find.byType(ScorecardCard), findsWidgets);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('component without a builder still offers the playground', (
      WidgetTester tester,
    ) async {
      await pumpComponentPage(tester, 'menu');
      expect(find.text('Trust scorecards'), findsOneWidget);
      // Every page has a Playground (Theme controls) even without props.
      expect(find.text('Playground'), findsOneWidget);
      // Scorecards still open from the top button.
      await tester.tap(find.text('Trust scorecards'));
      await tester.pumpAndSettle();
      expect(find.byType(ScorecardCard), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('button page is overflow-free at 1280, 900 and 390', (
      WidgetTester tester,
    ) async {
      for (final double width in <double>[1280, 900, 390]) {
        await pumpComponentPage(tester, 'button', width: width, height: 844);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow at width $width',
        );
      }
    });

    testWidgets('divider card passes with no exempt checks', (
      WidgetTester tester,
    ) async {
      await pumpComponentPage(tester, 'divider');
      await tester.tap(find.text('Trust scorecards'));
      await tester.pumpAndSettle();
      expect(find.text('Pass'), findsWidgets);
      expect(find.text('Exempt'), findsNothing);
      expect(find.text('Fail'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });
}
