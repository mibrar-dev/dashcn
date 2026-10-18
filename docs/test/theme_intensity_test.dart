// Motion intensity in the Theme Studio: document round-trip, Dart export,
// rail picker and theming page section.

import 'dart:convert';

import 'package:docs/generated/docs_preset_sources.dart';
import 'package:docs/theme/theme_dart_source.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/theme/theme_document_edits.dart';
import 'package:docs/ui/dashcn/theme/motion.dart';
import 'package:docs/widgets/theme_rail.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  group('ThemeDocument intensity', () {
    test('presets carry no intensity choice (standard applies)', () {
      final ThemeDocument document = ThemeDocument.fromPreset('neutral');
      expect(document.motionIntensity, isNull);
      expect(document.motionCustomPressScale, isNull);
      final MotionTokens motion = document.theme(Brightness.light).motion;
      expect(motion.intensity, MotionIntensity.standard);
      expect(motion.durationMultiplier, 1.0);
      expect(motion.pressScale, 0.96);
      expect(motion.enterOffset, 8.0);
    });

    test('standard is today\'s values', () {
      final ThemeDocument document = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionIntensity(MotionIntensity.standard);
      final MotionTokens motion = document.theme(Brightness.light).motion;
      expect(motion.intensity, MotionIntensity.standard);
      expect(
        motion.scaledDuration(const Duration(milliseconds: 200)),
        const Duration(milliseconds: 200),
      );
    });

    test('custom values change the multiplier and scale', () {
      final ThemeDocument document = ThemeDocument.fromPreset('neutral')
          .withMotionIntensity(MotionIntensity.custom)
          .withMotionCustomDurationMultiplier(2.0)
          .withMotionCustomPressScale(0.9)
          .withMotionCustomEnterOffset(16.0)
          .withMotionCustomCurve(MotionCurveName.spring);
      final MotionTokens motion = document.theme(Brightness.light).motion;
      expect(motion.intensity, MotionIntensity.custom);
      expect(motion.durationMultiplier, 2.0);
      expect(motion.pressScale, 0.9);
      expect(motion.enterOffset, 16.0);
      expect(motion.customCurve, MotionCurveName.spring);
    });

    test('intensity round-trips through JSON', () {
      final ThemeDocument custom = ThemeDocument.fromPreset('neutral')
          .withMotionIntensity(MotionIntensity.custom)
          .withMotionCustomDurationMultiplier(1.5)
          .withMotionCustomPressScale(0.94)
          .withMotionCustomEnterOffset(12.0)
          .withMotionCustomCurve(MotionCurveName.spring);
      final ThemeDocument back = ThemeDocument.fromJson(
        jsonDecode(custom.json) as Map<String, Object?>,
      );
      expect(back.motionIntensity, MotionIntensity.custom);
      expect(back.motionCustomDurationMultiplier, 1.5);
      expect(back.motionCustomPressScale, 0.94);
      expect(back.motionCustomEnterOffset, 12.0);
      expect(back.motionCustomCurve, MotionCurveName.spring);
      expect(back.theme(Brightness.light).motion.pressScale, 0.94);
      // Clearing restores the untouched document.
      final ThemeDocument cleared = back
          .withMotionIntensity(null)
          .withMotionCustomDurationMultiplier(null)
          .withMotionCustomPressScale(null)
          .withMotionCustomEnterOffset(null)
          .withMotionCustomCurve(null);
      expect(cleared.json, ThemeDocument.fromPreset('neutral').json);
    });

    test('rejects out-of-range custom legs', () {
      Map<String, Object?> withMotion(Map<String, Object?> motion) =>
          <String, Object?>{..._neutralJson(), 'motion': motion};
      expect(
        () => ThemeDocument.fromJson(
          withMotion(<String, Object?>{'intensity': 'hyper'}),
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
      expect(
        () => ThemeDocument.fromJson(
          withMotion(<String, Object?>{'pressScale': 0.5}),
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
      expect(
        () => ThemeDocument.fromJson(
          withMotion(<String, Object?>{'enterOffset': 99}),
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
      expect(
        () => ThemeDocument.fromJson(
          withMotion(<String, Object?>{'durationMultiplier': 9}),
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
      expect(
        () => ThemeDocument.fromJson(
          withMotion(<String, Object?>{'curve': 'bounce'}),
        ),
        throwsA(isA<ThemeDocumentException>()),
      );
    });

    test('edits preserve the intensity choice', () {
      final ThemeDocument custom = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionIntensity(MotionIntensity.expressive).withRadiusPx(10);
      expect(custom.motionIntensity, MotionIntensity.expressive);
      expect(
        custom.renamed('custom', 'Custom').motionIntensity,
        MotionIntensity.expressive,
      );
    });
  });

  group('intensity export', () {
    test('omits motion for untouched documents', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset('neutral'),
      );
      expect(source, isNot(contains('MotionTokens')));
      expect(source, isNot(contains('motion.dart')));
    });

    test('includes intensity when set', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset(
          'neutral',
        ).withMotionIntensity(MotionIntensity.expressive),
      );
      expect(source, contains('intensity: MotionIntensity.expressive'));
      expect(source, contains('motion.dart'));
    });

    test('includes custom legs when set', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset('neutral')
            .withMotionIntensity(MotionIntensity.custom)
            .withMotionCustomPressScale(0.9)
            .withMotionCustomCurve(MotionCurveName.spring),
      );
      expect(source, contains('intensity: MotionIntensity.custom'));
      expect(source, contains('customPressScale: 0.9'));
      expect(source, contains('customCurve: MotionCurveName.spring'));
    });
  });

  group('Theme Studio intensity', () {
    testWidgets('the Intensity row picks and Custom reveals its legs', (
      WidgetTester tester,
    ) async {
      final delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/themes');
      final Finder intensityRow = find.byKey(
        const ValueKey<String>('rail-row-intensity'),
      );
      await tester.scrollUntilVisible(
        intensityRow,
        100,
        scrollable: find
            .descendant(
              of: find.byType(ThemeRail),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pump();
      expect(find.text('Standard'), findsWidgets);
      // Custom legs are hidden until Custom is picked.
      expect(
        find.byKey(const ValueKey<String>('rail-row-motion-press')),
        findsNothing,
      );
      await tester.tap(intensityRow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.text('Custom').last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(
        docsState.themeModel.document.motionIntensity,
        MotionIntensity.custom,
      );
      expect(
        find.byKey(const ValueKey<String>('rail-row-motion-press')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('rail-row-motion-offset')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('rail-row-motion-duration')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('rail-row-motion-curve')),
        findsOneWidget,
      );
      expect(
        docsState.themeModel.dartSource,
        contains('intensity: MotionIntensity.custom'),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('the theming page documents intensity', (
      WidgetTester tester,
    ) async {
      final delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/theming');
      expect(find.text('Motion'), findsWidgets);
      expect(find.textContaining('Subtle'), findsWidgets);
      expect(find.textContaining('Custom'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}

/// The decoded neutral preset JSON for the rejection tests.
Map<String, Object?> _neutralJson() =>
    jsonDecode(kPresetSources['neutral']!.json) as Map<String, Object?>;
