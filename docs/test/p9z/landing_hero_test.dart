// P9-Z landing hero: every platform at once.
//
// The hero runs `auth-01` live in the iPhone, Android and desktop frames
// (deferred chunk), with Get started / Browse flows CTAs; narrow screens
// show one frame plus a device switcher.

import 'package:docs/landing/hero_demo.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  group('p9z landing hero', () {
    testWidgets('deferred demo loads on the landing page', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 1400, height: 900);
      await tester.pumpAndSettle();
      expect(find.text('Every platform at once'), findsOneWidget);
      expect(find.byType(LandingHeroDemo), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('wide screens show all three frames at once', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 1400, height: 900);
      await tester.pumpAndSettle();
      for (final String id in <String>['iphone', 'android', 'desktop']) {
        expect(
          find.byKey(ValueKey<String>('hero-frame-$id')),
          findsOneWidget,
          reason: 'missing $id frame',
        );
      }
      // No switcher on wide screens.
      expect(
        find.byKey(const ValueKey<String>('hero-device-iphone')),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('narrow screens show one frame plus a device switcher', (
      WidgetTester tester,
    ) async {
      await pumpDocsApp(tester, width: 390, height: 844);
      await tester.pumpAndSettle();
      expect(find.byType(LandingHeroDemo), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('hero-device-iphone')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('hero-device-android')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('hero-frame-iphone')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('hero-frame-android')),
        findsNothing,
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('hero-device-android')),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey<String>('hero-frame-android')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('hero-frame-iphone')),
        findsNothing,
      );
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
