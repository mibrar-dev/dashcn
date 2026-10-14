// P9-Z component page integration: frames + playground + scorecard.
//
// The preview runs inside `FramedPreview` (router `?frame=` round-trip),
// the Playground section seeds from `p.*` and reports back through the
// router, and the scorecard card sits below the playground.

import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/component_playground_section.dart';
import 'package:docs/widgets/component_scorecard_section.dart';
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

    testWidgets('button shows preview frames, playground and scorecard', (
      WidgetTester tester,
    ) async {
      await pumpComponentPage(tester, 'button');
      expect(
        find.byWidgetPredicate(
          (Widget w) => w is FramedPreview && w.id == 'button',
        ),
        findsOneWidget,
      );
      expect(find.text('Playground'), findsWidgets);
      expect(find.byType(PlaygroundPanel), findsOneWidget);
      expect(find.text('Trust scorecard'), findsWidgets);
      expect(find.byType(ScorecardCard), findsOneWidget);
      // Both new sections register TOC headings.
      expect(find.byType(ComponentPlaygroundSection), findsOneWidget);
      expect(find.byType(ComponentScorecardSection), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('component without a builder shows the coming-soon note', (
      WidgetTester tester,
    ) async {
      expect(hasPlayground('menu'), isFalse);
      await pumpComponentPage(tester, 'menu');
      expect(find.text('Playground'), findsWidgets);
      expect(
        find.text('Playground coming soon for this component.'),
        findsOneWidget,
      );
      expect(find.byType(PlaygroundPanel), findsNothing);
      expect(find.byType(ScorecardCard), findsOneWidget);
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

    testWidgets('exempt checks render Exempt, not Fail, on the card', (
      WidgetTester tester,
    ) async {
      await pumpComponentPage(tester, 'divider');
      expect(find.text('Exempt'), findsWidgets);
      expect(find.textContaining('Decorative element'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
