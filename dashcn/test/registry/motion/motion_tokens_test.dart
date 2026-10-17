// Motion token contract: defaults, curves, theme wiring and reduced-motion
// resolution.

import 'package:dashcn/src/primitives/motion/motion_scope.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MotionDurations', () {
    test('defaults sit in the subtle band', () {
      const MotionDurations durations = MotionDurations();
      expect(durations.instant, const Duration(milliseconds: 100));
      expect(durations.fast, const Duration(milliseconds: 150));
      expect(durations.base, const Duration(milliseconds: 200));
      expect(durations.slow, const Duration(milliseconds: 300));
    });

    test('copyWith replaces one leg', () {
      const MotionDurations durations = MotionDurations();
      final MotionDurations next = durations.copyWith(
        base: const Duration(milliseconds: 250),
      );
      expect(next.base, const Duration(milliseconds: 250));
      expect(next.fast, durations.fast);
    });

    test('lerp steps at the midpoint', () {
      const MotionDurations a = MotionDurations();
      final MotionDurations b = a.copyWith(
        base: const Duration(milliseconds: 250),
      );
      expect(MotionDurations.lerp(a, b, 0.0), a);
      expect(MotionDurations.lerp(a, b, 1.0), b);
      expect(MotionDurations.lerp(a, b, 0.25), a);
      expect(MotionDurations.lerp(a, b, 0.75), b);
    });
  });

  group('MotionCurves', () {
    test('standard and emphasized curves are bounded eases', () {
      const MotionCurves curves = MotionCurves();
      for (final Curve curve in <Curve>[
        curves.standard,
        curves.emphasizedOut,
        curves.emphasizedIn,
      ]) {
        expect(curve.transform(0.0), 0.0);
        expect(curve.transform(1.0), 1.0);
        final double mid = curve.transform(0.5);
        expect(mid, greaterThan(0.0));
        expect(mid, lessThan(1.0));
      }
    });

    test('spring overshoots past the end value', () {
      const MotionSpringCurve spring = MotionSpringCurve();
      expect(spring.transform(0.0), 0.0);
      expect(spring.transform(1.0), 1.0);
      bool overshot = false;
      for (int i = 1; i < 10; i++) {
        if (spring.transform(i / 10) > 1.0) {
          overshot = true;
        }
      }
      expect(overshot, isTrue, reason: 'spring never exceeds 1');
    });
  });

  group('MotionTokens', () {
    test('defaults are enabled with token timings', () {
      const MotionTokens motion = MotionTokens();
      expect(motion.enabled, isTrue);
      expect(motion.durations, const MotionDurations());
      expect(motion.curves, const MotionCurves());
    });

    test('copyWith, equality and lerp', () {
      const MotionTokens motion = MotionTokens();
      final MotionTokens off = motion.copyWith(enabled: false);
      expect(off.enabled, isFalse);
      expect(off, isNot(motion));
      expect(MotionTokens.lerp(motion, off, 0.25), motion);
      expect(MotionTokens.lerp(motion, off, 0.75), off);
    });
  });

  group('ThemeData.motion', () {
    test('exposed with defaults and preserved by copyWith', () {
      const ThemeData theme = ThemeData();
      expect(theme.motion.enabled, isTrue);
      expect(theme.motion.durations.fast, const Duration(milliseconds: 150));
      final ThemeData next = theme.copyWith(
        motion: () => const MotionTokens(enabled: false),
      );
      expect(next.motion.enabled, isFalse);
      expect(next.colors, theme.colors);
    });

    test('lerp keeps motion discrete', () {
      const ThemeData a = ThemeData();
      final ThemeData b = a.copyWith(
        motion: () => const MotionTokens(enabled: false),
      );
      expect(ThemeData.lerp(a, b, 0.25).motion.enabled, isTrue);
      expect(ThemeData.lerp(a, b, 0.75).motion.enabled, isFalse);
    });

    testWidgets('Theme.of exposes motion', (WidgetTester tester) async {
      late MotionTokens motion;
      await tester.pumpWidget(
        const Theme(
          data: ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: _MotionReader(),
          ),
        ),
      );
      motion = _MotionReader.of(tester);
      expect(motion.enabled, isTrue);
      expect(motion.durations.base, const Duration(milliseconds: 200));
    });
  });

  group('reduced motion resolution', () {
    testWidgets('motionReduced is false by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const Theme(
          data: ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: _ReducedReader(),
          ),
        ),
      );
      expect(_ReducedStore.value, isFalse);
    });

    testWidgets('MediaQuery.disableAnimations reduces motion', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Theme(
            data: ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: _ReducedReader(),
            ),
          ),
        ),
      );
      expect(_ReducedStore.value, isTrue);
    });

    testWidgets('motion.enabled false reduces motion', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData().copyWith(
            motion: () => const MotionTokens(enabled: false),
          ),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: _ReducedReader(),
          ),
        ),
      );
      expect(_ReducedStore.value, isTrue);
    });

    testWidgets('resolveMotionDuration collapses to zero when reduced', (
      WidgetTester tester,
    ) async {
      Duration? enabled;
      Duration? disabled;
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (BuildContext context) {
                enabled = resolveMotionDuration(
                  context,
                  const Duration(milliseconds: 200),
                );
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(enabled, const Duration(milliseconds: 200));
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Theme(
            data: ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: _DurationReader(),
            ),
          ),
        ),
      );
      disabled = _DurationReader.value;
      expect(disabled, Duration.zero);
    });
  });
}

/// Reads `Theme.of(context).motion` for the widget test above.
class _MotionReader extends StatelessWidget {
  const _MotionReader();

  static MotionTokens of(WidgetTester tester) {
    final Element element = tester.element(find.byType(_MotionReader));
    return Theme.of(element).motion;
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

/// Stores the last [motionReduced] reading for assertions.
class _ReducedStore {
  static bool value = false;
}

class _ReducedReader extends StatelessWidget {
  const _ReducedReader();

  @override
  Widget build(BuildContext context) {
    _ReducedStore.value = motionReduced(context);
    return const SizedBox();
  }
}

/// Stores the last resolved duration for assertions.
class _DurationReader extends StatelessWidget {
  const _DurationReader();

  static Duration? value;

  @override
  Widget build(BuildContext context) {
    _DurationReader.value = resolveMotionDuration(
      context,
      const Duration(milliseconds: 200),
    );
    return const SizedBox();
  }
}
