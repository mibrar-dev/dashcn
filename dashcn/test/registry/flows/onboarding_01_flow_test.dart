// End-to-end test for the `onboarding-01` flow.
//
// Walks every screen in light + dark and LTR + RTL: swipeable pages with
// Skip / Next / Get started, then the permission ask. Asserts the callbacks
// fire with the right data.

import 'package:dashcn/src/components/carousel/carousel.dart';
import 'package:dashcn/src/flows/onboarding-01/flow.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flows_support.dart';

/// Taps Next until the last page shows Get started (a prior swipe may have
/// already advanced the carousel).
Future<void> _toLastPage(WidgetTester tester) async {
  for (var i = 0; i < 4; i++) {
    if (find.text('Get started').evaluate().isNotEmpty) {
      return;
    }
    await tester.tap(find.text('Next'));
    await flowSettle(tester);
  }
  fail('never reached the last onboarding page');
}

void main() {
  for (final brightness in flowBrightnesses) {
    for (final direction in flowDirections) {
      testWidgets('walk ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        var skipped = 0;
        final granted = <bool>[];
        var finished = 0;
        await pumpFlow(
          tester,
          Onboarding01Flow(
            onSkip: () => skipped++,
            onPermissionChanged: granted.add,
            onFinished: () => finished++,
          ),
          brightness: brightness,
          direction: direction,
        );

        // Pages screen with a swipeable carousel.
        expect(find.text('Skip'), findsOneWidget);
        expect(find.text('Next'), findsOneWidget);
        await tester.drag(find.byType(Carousel), const Offset(-300, 0));
        await flowSettle(tester);
        expect(tester.takeException(), isNull);

        // Next through to the last page, then to the permission ask.
        await _toLastPage(tester);
        await tester.tap(find.text('Get started'));
        await flowSettle(tester);

        // Permission screen resolves through callbacks.
        expect(find.text('Enable notifications?'), findsOneWidget);
        await tester.tap(find.text('Not now'));
        await flowSettle(tester);
        expect(granted, <bool>[false]);
        expect(finished, 1);
        expect(skipped, 0);
      });

      testWidgets('skip ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        var skipped = 0;
        await pumpFlow(
          tester,
          Onboarding01Flow(onSkip: () => skipped++),
          brightness: brightness,
          direction: direction,
        );
        await tester.tap(find.text('Skip'));
        await flowSettle(tester);
        expect(skipped, 1);
      });

      testWidgets('allow ${brightness.name} ${direction.name}', (
        WidgetTester tester,
      ) async {
        final granted = <bool>[];
        var finished = 0;
        await pumpFlow(
          tester,
          Onboarding01Flow(
            onPermissionChanged: granted.add,
            onFinished: () => finished++,
          ),
          brightness: brightness,
          direction: direction,
        );
        await _toLastPage(tester);
        await tester.tap(find.text('Get started'));
        await flowSettle(tester);
        // Back returns to the pages, then forward again.
        await tester.tap(find.text('Back'));
        await flowSettle(tester);
        expect(find.text('Get started'), findsOneWidget);
        await tester.tap(find.text('Get started'));
        await flowSettle(tester);
        await tester.tap(find.text('Allow notifications'));
        await flowSettle(tester);
        expect(granted, <bool>[true]);
        expect(finished, 1);
      });
    }
  }
}
