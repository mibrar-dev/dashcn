// Motion tests for toast and gooey toast. Contract (MOTION.md): a toast
// slides in from its edge while it fades over 200 ms on a spring curve; the
// older toasts settle to 0.95 when a newer one arrives; a swipe follows the
// finger with no lag; an auto-dismiss fades over 150 ms. Gooey toast morphs
// from the compact pill to the expanded card over its open progress; reduced
// motion removes the morph (the final state appears at once).

import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/primitives/gooey/gooey_frame.dart';
import 'package:dashcn/src/primitives/toast_queue/toast_exit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'overlay_motion_harness.dart';

/// Pumps a toast layer with [controller] inside the app shell.
Future<void> _pumpToasts(WidgetTester tester, ToastController controller) {
  return tester.pumpWidget(
    DashcnApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: ToastLayer(
          controller: controller,
          child: const SizedBox.expand(),
        ),
      ),
    ),
  );
}

/// Sets the platform reduced-motion flag, which the overlays read.
void _reducedMotion(WidgetTester tester) {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
}

/// Vertical slide of the newest toast card (1 at start, 0 when settled).
double _enterDy(WidgetTester tester) {
  final SlideTransition slide = tester.widget<SlideTransition>(
    find.byType(SlideTransition).first,
  );
  return slide.position.value.dy;
}

/// Scale (x) of every stacked toast, in tree order.
List<double> _stackScales(WidgetTester tester) {
  return tester
      .widgetList<ToastStackDepth>(find.byType(ToastStackDepth))
      .map((ToastStackDepth depth) {
        final Finder transform = find.descendant(
          of: find.byWidget(depth),
          matching: find.byType(Transform),
        );
        return tester.widget<Transform>(transform.first).transform.storage[0];
      })
      .toList(growable: false);
}

/// Opacity of the exiting toast (its ToastExitTransition fade).
double _exitOpacity(WidgetTester tester) {
  final Finder fade = find.descendant(
    of: find.byWidgetPredicate((Widget w) => w is ToastExitTransition),
    matching: find.byType(FadeTransition),
  );
  return tester.widget<FadeTransition>(fade.first).opacity.value;
}

/// Open progress of the first gooey toast (0 compact, 1 expanded).
double _gooeyProgress(WidgetTester tester) => tester
    .widget<GooeySurfaceFrame>(find.byType(GooeySurfaceFrame).first)
    .progress;

Future<void> _pumpGooey(WidgetTester tester, GooeyToastController controller) {
  return tester.pumpWidget(
    DashcnApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: GooeyToastLayer(
          controller: controller,
          child: const SizedBox.expand(),
        ),
      ),
    ),
  );
}

void main() {
  group('toast', () {
    testWidgets('enter slides in from its edge and settles', (
      WidgetTester tester,
    ) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      await _pumpToasts(tester, controller);
      controller.showToast(builder: (BuildContext c) => const Text('Saved'));
      await tester.pump();
      final List<double> dy = await sampleFrames(
        tester,
        () => _enterDy(tester),
        frames: 10,
        stepMs: 20,
      );
      expect(dy.first, greaterThan(0.1), reason: 'starts below its rest');
      expect(dy.last, closeTo(0.0, 0.01), reason: 'settles in place');
      // The spring curve overshoots by a few percent, never by more.
      expect(
        dy.reduce((double a, double b) => a < b ? a : b),
        greaterThan(-0.1),
      );
      expect(distinctCount(dy), greaterThan(3));
      await tester.pump(const Duration(milliseconds: 300));
      controller.dismiss(controller.activeIds.single);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('a newer toast settles the older one to 0.95', (
      WidgetTester tester,
    ) async {
      // Stacking mode: by default a new toast replaces the one in its slot
      // (singlePerSlot), so the stack depth only shows when toasts stack.
      final ToastController controller = ToastController(singlePerSlot: false);
      addTearDown(controller.dispose);
      await _pumpToasts(tester, controller);
      controller.showToast(builder: (BuildContext c) => const Text('First'));
      await tester.pump(const Duration(milliseconds: 300));
      controller.showToast(builder: (BuildContext c) => const Text('Second'));
      await tester.pump();
      final List<List<double>> frames = <List<double>>[];
      for (int i = 0; i <= 10; i++) {
        frames.add(_stackScales(tester));
        await tester.pump(const Duration(milliseconds: 20));
      }
      final List<double> settled = frames.last;
      expect(
        settled.any((double s) => (s - 0.95).abs() < 0.01),
        isTrue,
        reason: 'the older toast settles to 0.95',
      );
      expect(
        settled.any((double s) => (s - 1.0).abs() < 0.01),
        isTrue,
        reason: 'the newest toast stays at 1',
      );
      final List<double> smallest = frames
          .map(
            (List<double> f) => f.reduce((double a, double b) => a < b ? a : b),
          )
          .toList(growable: false);
      expect(
        distinctCount(smallest),
        greaterThan(2),
        reason: 'shrinks over time',
      );
      expect(smallest.last, closeTo(0.95, 0.01));
      for (final String id in controller.activeIds.toList()) {
        controller.dismiss(id);
      }
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('a swipe follows the finger with no lag', (
      WidgetTester tester,
    ) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      await _pumpToasts(tester, controller);
      controller.showToast(builder: (BuildContext c) => const Text('Swipe me'));
      await tester.pump(const Duration(milliseconds: 300));
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.text('Swipe me')),
      );
      await gesture.moveBy(const Offset(-40, 0));
      await tester.pump();
      final AnimatedSlide slide = tester.widget<AnimatedSlide>(
        find.byType(AnimatedSlide).first,
      );
      expect(
        slide.offset.dx,
        closeTo(-40 / 300, 1e-6),
        reason: 'tracks the finger',
      );
      expect(slide.duration, Duration.zero, reason: 'no easing while dragging');
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 300));
      controller.dismiss(controller.activeIds.single);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('dismiss fades out over 150 ms, then the toast is removed', (
      WidgetTester tester,
    ) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      await _pumpToasts(tester, controller);
      controller.showToast(builder: (BuildContext c) => const Text('Bye'));
      await tester.pump(const Duration(milliseconds: 300));
      controller.dismiss(controller.activeIds.single);
      await tester.pump();
      final List<double> opacity = await sampleFrames(
        tester,
        () => _exitOpacity(tester),
        frames: 6,
        stepMs: 25,
      );
      expect(isNonIncreasing(opacity), isTrue, reason: 'fades out');
      expect(opacity.first, closeTo(1.0, 0.2));
      expect(opacity.last, lessThan(0.5));
      await tester.pump(const Duration(milliseconds: 600));
      expect(controller.activeIds, isEmpty);
    });

    testWidgets('reduced motion: the toast appears in its final place', (
      WidgetTester tester,
    ) async {
      _reducedMotion(tester);
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      await _pumpToasts(tester, controller);
      controller.showToast(builder: (BuildContext c) => const Text('Still'));
      await tester.pump();
      expect(_enterDy(tester), closeTo(0.0, 1e-6));
      controller.dismiss(controller.activeIds.single);
      await tester.pump(const Duration(milliseconds: 600));
    });
  });

  group('gooey toast', () {
    GooeyToastOptions options() => const GooeyToastOptions(
      title: 'Saved',
      description: 'Everything is in sync.',
    );

    testWidgets('open morphs from the compact pill to the card and settles', (
      WidgetTester tester,
    ) async {
      final GooeyToastController controller = GooeyToastController();
      addTearDown(controller.dispose);
      await _pumpGooey(tester, controller);
      await tester.pump();
      final String id = controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        options(),
      );
      await tester.pump();
      final List<double> progress = await sampleFrames(
        tester,
        () => _gooeyProgress(tester),
        frames: 40,
        stepMs: 25,
      );
      expect(progress.first, lessThan(0.5), reason: 'starts as a pill');
      expect(progress.last, closeTo(1.0, 1e-3), reason: 'settles open');
      expect(isNonDecreasing(progress), isTrue);
      expect(distinctCount(progress), greaterThan(3));
      controller.dismiss(id);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('reduced motion: no morph, the card is open at once', (
      WidgetTester tester,
    ) async {
      _reducedMotion(tester);
      final GooeyToastController controller = GooeyToastController();
      addTearDown(controller.dispose);
      await _pumpGooey(tester, controller);
      await tester.pump();
      final String id = controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        options(),
      );
      // No open animation (duration zero); only the autopilot's 150 ms expand
      // delay, as in the component's own reduced-motion test.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(_gooeyProgress(tester), closeTo(1.0, 1e-6));
      controller.dismiss(id);
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
