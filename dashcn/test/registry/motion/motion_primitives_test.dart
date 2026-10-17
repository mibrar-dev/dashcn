// Shared motion primitive contract: t=0, mid-flight and end values, and
// reduced motion collapsing to the end value with no tickers.

import 'dart:ui' show PointerDeviceKind;

import 'package:dashcn/src/primitives/motion/error_shake.dart';
import 'package:dashcn/src/primitives/motion/fade_slide_in.dart';
import 'package:dashcn/src/primitives/motion/hover_elevate.dart';
import 'package:dashcn/src/primitives/motion/motion_chevron.dart';
import 'package:dashcn/src/primitives/motion/motion_enter.dart';
import 'package:dashcn/src/primitives/motion/press_scale.dart';
import 'package:dashcn/src/primitives/motion/scale_in.dart';
import 'package:dashcn/src/primitives/motion/stagger.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] under the motion theme; [disabled] wraps it in
/// `MediaQuery.disableAnimations`.
Future<void> pumpMotion(
  WidgetTester tester,
  Widget child, {
  bool disabled = false,
  ThemeData theme = const ThemeData(),
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(800, 600),
      ).copyWith(disableAnimations: disabled),
      child: Theme(
        data: theme,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

ThemeData get _noMotion => const ThemeData().copyWith(
  motion: () => const MotionTokens(enabled: false),
);

void main() {
  group('PressScale', () {
    testWidgets('scales down on press and back on release', (
      WidgetTester tester,
    ) async {
      await pumpMotion(tester, const PressScale(child: Text('press')));
      double scale() =>
          tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale;
      expect(scale(), 1.0);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.text('press')),
      );
      await tester.pump(const Duration(milliseconds: 50));
      final double mid = scale();
      expect(mid, lessThan(1.0));
      expect(mid, greaterThan(0.9));
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 300));
      expect(scale(), 1.0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion snaps to the pressed end value', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const PressScale(child: Text('press')),
        disabled: true,
      );
      double scale() =>
          tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale;
      expect(scale(), 1.0);
      final TestGesture gesture = await tester.startGesture(
        tester.getCenter(find.text('press')),
      );
      await tester.pump(const Duration(milliseconds: 50));
      // Zero duration: the pressed end value shows instantly, with no
      // mid-flight and no ticker.
      expect(scale(), 0.96);
      expect(tester.binding.transientCallbackCount, 0);
      await gesture.up();
      await tester.pump(const Duration(milliseconds: 50));
      expect(scale(), 1.0);
      expect(tester.takeException(), isNull);
    });
  });

  group('FadeSlideIn', () {
    testWidgets('fades up from t=0 to the end value', (
      WidgetTester tester,
    ) async {
      await pumpMotion(tester, const FadeSlideIn(child: Text('enter')));
      final FadeSlideInState state = tester.state<FadeSlideInState>(
        find.byType(FadeSlideIn),
      );
      expect(state.progress, 0.0);
      await tester.pump(const Duration(milliseconds: 50));
      final double mid = state.progress;
      expect(mid, greaterThan(0.0));
      expect(mid, lessThan(1.0));
      expect(find.byType(Opacity), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 300));
      expect(state.progress, 1.0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion builds the end value at t=0', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const FadeSlideIn(child: Text('enter')),
        disabled: true,
      );
      final FadeSlideInState state = tester.state<FadeSlideInState>(
        find.byType(FadeSlideIn),
      );
      expect(state.progress, 1.0);
      // No animated wrapper: the child builds directly.
      expect(find.byType(Opacity), findsNothing);
      expect(find.byType(Transform), findsNothing);
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('motion.enabled false matches disableAnimations', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const FadeSlideIn(child: Text('enter')),
        theme: _noMotion,
      );
      final FadeSlideInState state = tester.state<FadeSlideInState>(
        find.byType(FadeSlideIn),
      );
      expect(state.progress, 1.0);
      expect(find.byType(Opacity), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('ScaleIn', () {
    testWidgets('grows from 0.96 with a fade', (WidgetTester tester) async {
      await pumpMotion(tester, const ScaleIn(child: Text('pop')));
      final ScaleInState state = tester.state<ScaleInState>(
        find.byType(ScaleIn),
      );
      expect(state.progress, 0.0);
      await tester.pump(const Duration(milliseconds: 50));
      expect(state.progress, greaterThan(0.0));
      expect(state.progress, lessThan(1.0));
      await tester.pump(const Duration(milliseconds: 300));
      expect(state.progress, 1.0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion builds final at t=0', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const ScaleIn(child: Text('pop')),
        disabled: true,
      );
      expect(tester.state<ScaleInState>(find.byType(ScaleIn)).progress, 1.0);
      expect(find.byType(Opacity), findsNothing);
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  });

  group('MotionEnter', () {
    testWidgets('enters once on mount', (WidgetTester tester) async {
      await pumpMotion(tester, const MotionEnter(child: Text('banner')));
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(Opacity), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion builds final at t=0', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const MotionEnter(child: Text('banner')),
        disabled: true,
      );
      expect(find.byType(Opacity), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });

  group('StaggerChildren', () {
    testWidgets('staggers siblings and settles together', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const StaggerChildren(
          children: <Widget>[Text('a'), Text('b'), Text('c')],
        ),
      );
      final List<FadeSlideInState> states = tester
          .stateList<FadeSlideInState>(find.byType(FadeSlideIn))
          .toList();
      expect(states, hasLength(3));
      // Tickers start on the next pumped frame, so at t=50 only the
      // undelayed first item has moved; at t=150 the stagger is visible.
      await tester.pump(const Duration(milliseconds: 50));
      expect(states[0].progress, greaterThan(0.0));
      await tester.pump(const Duration(milliseconds: 100));
      final List<double> mid = <double>[
        for (final FadeSlideInState s in states) s.progress,
      ];
      // The first item leads the last one.
      expect(mid[0], greaterThan(mid[2]));
      await tester.pump(const Duration(milliseconds: 500));
      for (final FadeSlideInState s in states) {
        expect(s.progress, 1.0);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('caps staggering at six items', (WidgetTester tester) async {
      await pumpMotion(
        tester,
        StaggerChildren(
          children: <Widget>[for (int i = 0; i < 8; i++) Text('item $i')],
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));
      final List<FadeSlideInState> states = tester
          .stateList<FadeSlideInState>(find.byType(FadeSlideIn))
          .toList();
      expect(states, hasLength(8));
      // Items past the cap share the last delay, so 5, 6 and 7 match.
      expect(states[5].progress, states[6].progress);
      expect(states[6].progress, states[7].progress);
      await tester.pump(const Duration(milliseconds: 800));
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion builds every child final', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const StaggerChildren(
          children: <Widget>[Text('a'), Text('b'), Text('c')],
        ),
        disabled: true,
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(Opacity), findsNothing);
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  });

  group('ErrorShake', () {
    testWidgets('shakes once when the error appears', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        const ErrorShake(trigger: null, child: Text('field')),
      );
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: Theme(
            data: ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: ErrorShake(trigger: 'required', child: Text('field')),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));
      final ErrorShakeState state = tester.state<ErrorShakeState>(
        find.byType(ErrorShake),
      );
      expect(state.shakeCount, 1);
      double dx() {
        final Transform transform = tester.widget<Transform>(
          find.byType(Transform),
        );
        return transform.transform.getTranslation().x;
      }

      expect(dx(), isNot(0.0));
      await tester.pump(const Duration(milliseconds: 300));
      expect(dx(), 0.0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion never shakes', (WidgetTester tester) async {
      await pumpMotion(
        tester,
        const ErrorShake(trigger: 'required', child: Text('field')),
        disabled: true,
      );
      await tester.pump(const Duration(milliseconds: 100));
      final ErrorShakeState state = tester.state<ErrorShakeState>(
        find.byType(ErrorShake),
      );
      expect(state.shakeCount, 0);
      expect(find.byType(Transform), findsNothing);
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  });

  group('MotionChevron', () {
    double cosAngle(WidgetTester tester) {
      final Transform transform = tester.widget<Transform>(
        find.byType(Transform),
      );
      return transform.transform.entry(0, 0);
    }

    testWidgets('rotates half a turn on expand', (WidgetTester tester) async {
      await pumpMotion(
        tester,
        const MotionChevron(expanded: false, child: Text('v')),
      );
      await tester.pump(const Duration(milliseconds: 300));
      expect(cosAngle(tester), 1.0);
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(800, 600)),
          child: Theme(
            data: ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: MotionChevron(expanded: true, child: Text('v')),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 50));
      final double mid = cosAngle(tester);
      expect(mid, lessThan(1.0));
      expect(mid, greaterThan(-1.0));
      await tester.pump(const Duration(milliseconds: 300));
      expect(cosAngle(tester), closeTo(-1.0, 0.001));
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion snaps', (WidgetTester tester) async {
      await pumpMotion(
        tester,
        const MotionChevron(expanded: true, child: Text('v')),
        disabled: true,
      );
      await tester.pump(const Duration(milliseconds: 50));
      expect(cosAngle(tester), closeTo(-1.0, 0.001));
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  });

  group('HoverElevate', () {
    testWidgets('lifts on hover and rests on exit', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        HoverElevate(
          decoration: BoxDecoration(border: Border.all()),
          hoverDecoration: BoxDecoration(
            border: Border.all(),
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: const Text('card'),
        ),
      );
      Matrix4 transform() => tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer))
          .transform!;
      expect(transform(), Matrix4.identity());
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(find.text('card')));
      await tester.pump(const Duration(milliseconds: 50));
      expect(transform(), isNot(Matrix4.identity()));
      await gesture.moveTo(Offset.zero);
      await tester.pump(const Duration(milliseconds: 300));
      expect(transform(), Matrix4.identity());
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion snaps to the hover end value', (
      WidgetTester tester,
    ) async {
      await pumpMotion(
        tester,
        HoverElevate(
          decoration: BoxDecoration(border: Border.all()),
          hoverDecoration: BoxDecoration(
            border: Border.all(),
            boxShadow: const <BoxShadow>[
              BoxShadow(blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: const Text('card'),
        ),
        disabled: true,
      );
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer();
      await gesture.moveTo(tester.getCenter(find.text('card')));
      await tester.pump(const Duration(milliseconds: 50));
      // Zero duration: the lifted end value shows instantly, with no ticker.
      expect(
        tester
            .widget<AnimatedContainer>(find.byType(AnimatedContainer))
            .transform!,
        Matrix4.translationValues(0, -2.0, 0),
      );
      expect(tester.binding.transientCallbackCount, 0);
      await gesture.moveTo(Offset.zero);
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        tester
            .widget<AnimatedContainer>(find.byType(AnimatedContainer))
            .transform!,
        Matrix4.identity(),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
