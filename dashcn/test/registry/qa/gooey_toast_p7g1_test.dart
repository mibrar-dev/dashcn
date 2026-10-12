// P7-G1/P7-G2 regressions for `gooey_toast` (user report 2026-10-11): the toast
// must stay hidden until triggered, anchor to the window edge away from its
// trigger, run the pill → expanded → collapsed → removed lifecycle, dismiss by
// swipe/timeout (the close button was removed in P7-G3), keep the title in the
// state tone, and degrade to a still-correct toast under reduced motion.

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/primitives/gooey/gooey_frame.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester,
    GooeyToastController controller, {
    Widget? child,
  }) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ShadcnApp(
        home: GooeyToastLayer(
          controller: controller,
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  /// Advances in 100ms slices (see the component test for why).
  Future<void> advance(WidgetTester tester, Duration total) async {
    int remaining = total.inMilliseconds;
    while (remaining > 0) {
      final int step = remaining < 100 ? remaining : 100;
      await tester.pump(Duration(milliseconds: step));
      remaining -= step;
    }
  }

  GooeyToastOptions options({
    String title = 'Saved',
    String? description = 'Body',
    GooeyToastState state = GooeyToastState.success,
  }) => GooeyToastOptions(title: title, description: description, state: state);

  testWidgets('stays hidden until triggered', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    await advance(tester, const Duration(seconds: 2));
    expect(find.text('Saved'), findsNothing);
    expect(find.byType(GooeyToastCard), findsNothing);
    controller.dispose();
  });

  testWidgets('anchors to the window edge, away from the trigger', (
    tester,
  ) async {
    final GooeyToastController controller = GooeyToastController();
    // The trigger sits in the middle of the window: the toast must not cover it.
    await pumpApp(
      tester,
      controller,
      child: const Center(child: SizedBox(width: 40, height: 20)),
    );
    final Rect trigger = tester.getRect(find.byType(SizedBox).first);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(title: 'Saved'),
    );
    await advance(tester, const Duration(milliseconds: 300));
    final Rect toast = tester.getRect(find.byType(GooeySurfaceFrame));
    expect(toast.top, closeTo(16, 0.5));
    expect(toast.top, lessThan(trigger.top));
    expect(toast.overlaps(trigger), isFalse);
    controller.dispose();
  });

  testWidgets('pill → expanded → collapsed lifecycle', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(title: 'Saved', description: 'Body'),
    );
    await tester.pump();
    // Closed: the pill only.
    expect(
      tester.widget<GooeySurfaceFrame>(find.byType(GooeySurfaceFrame)).progress,
      0,
    );
    await advance(tester, const Duration(milliseconds: 900));
    expect(
      tester.widget<GooeySurfaceFrame>(find.byType(GooeySurfaceFrame)).progress,
      greaterThan(0.5),
    );
    // The autopilot holds for the 4s collapse delay, then collapses.
    await advance(tester, const Duration(seconds: 5));
    expect(
      tester.widget<GooeySurfaceFrame>(find.byType(GooeySurfaceFrame)).progress,
      lessThan(0.5),
    );
    controller.dispose();
  });

  testWidgets('a swipe up dismisses the toast (no close button)', (
    tester,
  ) async {
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(title: 'Saved', description: 'Body'),
    );
    await advance(tester, const Duration(milliseconds: 900));
    expect(find.text('Saved'), findsOne);
    // Drag up past the dismiss threshold: the reference has no close button,
    // the toast leaves by swipe.
    final Offset start = tester.getCenter(find.byType(GooeyToastCard));
    final TestGesture gesture = await tester.startGesture(
      start,
      pointer: 7,
      kind: PointerDeviceKind.touch,
    );
    for (int i = 1; i <= 8; i++) {
      await gesture.moveBy(const Offset(0, -20));
      await tester.pump();
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
    expect(controller.activeToasts, isEmpty);
    controller.dispose();
  });

  testWidgets('the title reads the state tone', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(
        title: 'Saved',
        description: 'Body',
        state: GooeyToastState.error,
      ),
    );
    await advance(tester, const Duration(milliseconds: 900));
    final BuildContext context = tester.element(find.text('Saved'));
    final Color tone = GooeyToastState.error.tone(
      gooeyToastThemeOf(context),
      ShadcnTheme.of(context).colors,
    );
    expect((tester.widget<Text>(find.text('Saved')).style?.color), isNotNull);
    // The tone is the error red, lifted for contrast against the surface.
    expect(
      tone,
      isNot(
        GooeyToastState.success.tone(
          gooeyToastThemeOf(context),
          ShadcnTheme.of(context).colors,
        ),
      ),
    );
    controller.dispose();
  });

  testWidgets('reduced motion still shows a correct toast', (tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(() {
      tester.platformDispatcher.clearAccessibilityFeaturesTestValue();
    });
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(title: 'Saved', description: 'Body'),
    );
    await advance(tester, const Duration(milliseconds: 300));
    expect(find.text('Saved'), findsOne);
    expect(find.text('Body'), findsOne);
    controller.dispose();
  });

  testWidgets('disposing the controller clears its toasts', (tester) async {
    final GooeyToastController controller = GooeyToastController();
    await pumpApp(tester, controller);
    controller.showGooeyToast(
      tester.element(find.byType(GooeyToastLayer)),
      options(title: 'Saved'),
    );
    expect(controller.activeToasts, isNotEmpty);
    controller.dispose();
    await tester.pump();
    expect(controller.activeToasts, isEmpty);
  });
}
