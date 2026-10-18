// Home hero without device frames.
//
// The device-frame showcase was removed from the home route: the landing
// shows the H1, the CTAs and the live component collage (no device frame).
// Device frames stay on component/flow pages.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/collage.dart';
import 'package:docs/widgets/device_frame/device_frame.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  group('home without device frames', () {
    testWidgets('landing shows the collage and no device frame', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 1400, height: 900);
      await tester.pumpAndSettle();
      expect(find.text('Every platform at once'), findsOneWidget);
      expect(find.byType(DocsCollage), findsOneWidget);
      expect(find.byType(DeviceFrame), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no hero frame keys on the home route', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 1400, height: 900);
      await tester.pumpAndSettle();
      for (final String id in <String>['iphone', 'android', 'desktop']) {
        expect(
          find.byKey(ValueKey<String>('hero-frame-$id')),
          findsNothing,
          reason: 'home must not carry a $id frame',
        );
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('component pages still carry device frames', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 1400,
        height: 900,
      );
      await goTo(tester, delegate, '/docs/components/button?frame=iphone');
      await tester.pumpAndSettle();
      expect(find.byType(DeviceFrame), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('CTAs go to installation and flows', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 1400,
        height: 900,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Browse flows'));
      await tester.pumpAndSettle();
      expect(delegate.currentConfiguration.route, DocsRoute.flows);
    });

    testWidgets('hero is overflow-free at 1400, 900 and 390', (
      WidgetTester tester,
    ) async {
      for (final double width in <double>[1400, 900, 390]) {
        await pumpDocsApp(tester, width: width, height: 900);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow at width $width',
        );
      }
    });
  });
}
