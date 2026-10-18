// Intensity contract: standard is today's values (the default); subtle,
// expressive and custom scale durations, press and enter offset from one
// place; custom legs round-trip through copyWith/equality.

import 'package:dashcn/src/primitives/motion/motion_scope.dart';
import 'package:dashcn/src/theme/motion.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MotionIntensity defaults', () {
    test('standard is the default with today\'s values', () {
      const MotionTokens motion = MotionTokens();
      expect(motion.intensity, MotionIntensity.standard);
      expect(motion.durationMultiplier, 1.0);
      expect(motion.pressScale, 0.96);
      expect(motion.enterOffset, 8.0);
      expect(motion.durations.base, const Duration(milliseconds: 200));
    });

    test('subtle shortens and softens', () {
      const MotionTokens motion = MotionTokens(
        intensity: MotionIntensity.subtle,
      );
      expect(motion.durationMultiplier, 0.75);
      expect(motion.pressScale, 0.98);
      expect(motion.enterOffset, 4.0);
    });

    test('expressive lengthens and deepens', () {
      const MotionTokens motion = MotionTokens(
        intensity: MotionIntensity.expressive,
      );
      expect(motion.durationMultiplier, 1.5);
      expect(motion.pressScale, 0.94);
      expect(motion.enterOffset, 12.0);
    });

    test('custom uses the explicit legs', () {
      const MotionTokens motion = MotionTokens(
        intensity: MotionIntensity.custom,
        customDurationMultiplier: 2.0,
        customPressScale: 0.9,
        customEnterOffset: 16.0,
        customCurve: MotionCurveName.spring,
      );
      expect(motion.durationMultiplier, 2.0);
      expect(motion.pressScale, 0.9);
      expect(motion.enterOffset, 16.0);
      expect(
        motion.resolveEnterCurve(motion.curves.emphasizedOut),
        motion.curves.spring,
      );
    });

    test('custom legs clamp to safe ranges', () {
      const MotionTokens motion = MotionTokens(
        intensity: MotionIntensity.custom,
        customPressScale: 0.2,
        customEnterOffset: 99.0,
      );
      expect(motion.pressScale, 0.8);
      expect(motion.enterOffset, 24.0);
    });

    test('scaledDuration applies the multiplier', () {
      const Duration base = Duration(milliseconds: 200);
      expect(
        const MotionTokens().scaledDuration(base),
        const Duration(milliseconds: 200),
      );
      expect(
        const MotionTokens(
          intensity: MotionIntensity.subtle,
        ).scaledDuration(base),
        const Duration(milliseconds: 150),
      );
      expect(
        const MotionTokens(
          intensity: MotionIntensity.expressive,
        ).scaledDuration(base),
        const Duration(milliseconds: 300),
      );
      expect(
        const MotionTokens(
          intensity: MotionIntensity.custom,
          customDurationMultiplier: 2.0,
        ).scaledDuration(base),
        const Duration(milliseconds: 400),
      );
    });

    test('scaledOffset scales proportionally to 8 px', () {
      const Offset base = Offset(0, 8);
      expect(const MotionTokens().scaledOffset(base), const Offset(0, 8));
      expect(
        const MotionTokens(
          intensity: MotionIntensity.subtle,
        ).scaledOffset(base),
        const Offset(0, 4),
      );
      expect(
        const MotionTokens(
          intensity: MotionIntensity.expressive,
        ).scaledOffset(base),
        const Offset(0, 12),
      );
      expect(const MotionTokens().scaledOffset(Offset.zero), Offset.zero);
    });

    test('resolveEnterCurve keeps presets, custom overrides', () {
      const MotionTokens standard = MotionTokens();
      expect(
        standard.resolveEnterCurve(standard.curves.emphasizedOut),
        standard.curves.emphasizedOut,
      );
      const MotionTokens custom = MotionTokens(
        intensity: MotionIntensity.custom,
        customCurve: MotionCurveName.spring,
      );
      expect(
        custom.resolveEnterCurve(custom.curves.emphasizedOut),
        custom.curves.spring,
      );
      expect(
        custom.resolveEnterCurve(
          custom.curves.emphasizedOut,
          override: custom.curves.standard,
        ),
        custom.curves.standard,
      );
    });

    test('copyWith, equality and lerp carry intensity', () {
      const MotionTokens base = MotionTokens();
      final MotionTokens custom = base.copyWith(
        intensity: MotionIntensity.custom,
        customPressScale: 0.9,
      );
      expect(custom.intensity, MotionIntensity.custom);
      expect(custom.customPressScale, 0.9);
      expect(custom, isNot(base));
      expect(MotionTokens.lerp(base, custom, 0.25), base);
      expect(MotionTokens.lerp(base, custom, 0.75), custom);
    });

    test('MotionCurveName round-trips by wire name', () {
      for (final MotionCurveName curve in MotionCurveName.values) {
        expect(MotionCurveName.parse(curve.wireName), curve);
      }
      expect(MotionCurveName.parse('bogus'), MotionCurveName.emphasizedOut);
      expect(MotionCurveName.parse(null), MotionCurveName.emphasizedOut);
    });
  });

  group('intensity duration resolution', () {
    testWidgets('resolveMotionDuration scales by intensity', (
      WidgetTester tester,
    ) async {
      Duration? subtle;
      Duration? expressive;
      await tester.pumpWidget(
        Theme(
          data: const ThemeData().copyWith(
            motion: () => const MotionTokens(intensity: MotionIntensity.subtle),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (BuildContext context) {
                subtle = resolveMotionDuration(
                  context,
                  const Duration(milliseconds: 200),
                );
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(subtle, const Duration(milliseconds: 150));
      await tester.pumpWidget(
        Theme(
          data: const ThemeData().copyWith(
            motion: () =>
                const MotionTokens(intensity: MotionIntensity.expressive),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (BuildContext context) {
                expressive = resolveMotionDuration(
                  context,
                  const Duration(milliseconds: 200),
                );
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(expressive, const Duration(milliseconds: 300));
    });

    testWidgets('custom multiplier changes the resolved duration', (
      WidgetTester tester,
    ) async {
      Duration? resolved;
      await tester.pumpWidget(
        Theme(
          data: const ThemeData().copyWith(
            motion: () => const MotionTokens(
              intensity: MotionIntensity.custom,
              customDurationMultiplier: 2.0,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (BuildContext context) {
                resolved = resolveMotionDuration(
                  context,
                  const Duration(milliseconds: 100),
                );
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(resolved, const Duration(milliseconds: 200));
    });
  });
}
