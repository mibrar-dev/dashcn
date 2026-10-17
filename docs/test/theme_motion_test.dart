// Motion tokens in the Theme Studio: the document round-trip, the Dart
// export, the rail toggle and the theming page section.

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
  group('ThemeDocument motion', () {
    test('presets carry no motion choice (defaults apply)', () {
      final ThemeDocument document = ThemeDocument.fromPreset('neutral');
      expect(document.motionEnabled, isNull);
      expect(document.theme(Brightness.light).motion.enabled, isTrue);
      expect(
        document.theme(Brightness.light).motion.durations.base,
        const Duration(milliseconds: 200),
      );
    });

    test('motion round-trips through JSON', () {
      final ThemeDocument off = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionEnabled(false);
      expect(off.motionEnabled, isFalse);
      final ThemeDocument back = ThemeDocument.fromJson(
        jsonDecode(off.json) as Map<String, Object?>,
      );
      expect(back.motionEnabled, isFalse);
      final ThemeDocument on = off.withMotionEnabled(true);
      expect(
        (ThemeDocument.fromJson(
          jsonDecode(on.json) as Map<String, Object?>,
        )).motionEnabled,
        isTrue,
      );
      expect(
        ThemeDocument.fromPreset('neutral').withMotionEnabled(null).json,
        ThemeDocument.fromPreset('neutral').json,
      );
    });

    test('rejects a non-bool motion block', () {
      expect(
        () => ThemeDocument.fromJson(<String, Object?>{
          ..._neutralJson(),
          'motion': <String, Object?>{'enabled': 'yes'},
        }),
        throwsA(isA<ThemeDocumentException>()),
      );
    });

    test('theme() resolves MotionTokens from the toggle', () {
      final ThemeDocument off = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionEnabled(false);
      expect(off.theme(Brightness.light).motion.enabled, isFalse);
      expect(off.theme(Brightness.dark).motion.enabled, isFalse);
      final MotionTokens on = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionEnabled(true).theme(Brightness.light).motion;
      expect(on.enabled, isTrue);
      expect(on.durations, const MotionDurations());
    });

    test('edits preserve the motion choice', () {
      final ThemeDocument off = ThemeDocument.fromPreset(
        'neutral',
      ).withMotionEnabled(false).withRadiusPx(10);
      expect(off.motionEnabled, isFalse);
      expect(off.renamed('custom', 'Custom').motionEnabled, isFalse);
    });
  });

  group('motion export', () {
    test('omits motion for untouched documents', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset('neutral'),
      );
      expect(source, isNot(contains('MotionTokens')));
      expect(source, isNot(contains('motion.dart')));
    });

    test('includes motion when enabled', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset('neutral').withMotionEnabled(true),
      );
      expect(source, contains('motion: const MotionTokens()'));
      expect(source, contains('motion.dart'));
    });

    test('includes motion when disabled', () {
      final String source = themeDartSource(
        ThemeDocument.fromPreset('neutral').withMotionEnabled(false),
      );
      expect(source, contains('motion: const MotionTokens(enabled: false)'));
      expect(source, contains('motion.dart'));
    });
  });

  group('Theme Studio', () {
    testWidgets('the Motion row toggles the document', (
      WidgetTester tester,
    ) async {
      final delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/themes');
      expect(find.text('Motion'), findsWidgets);
      expect(docsState.themeModel.document.motionEnabled, isNull);
      final Finder motionRow = find.byKey(
        const ValueKey<String>('rail-row-motion'),
      );
      await tester.scrollUntilVisible(
        motionRow,
        100,
        scrollable: find
            .descendant(
              of: find.byType(ThemeRail),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pump();
      await tester.tap(motionRow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(docsState.themeModel.document.motionEnabled, isFalse);
      expect(find.text('Off'), findsWidgets);
      expect(
        docsState.themeModel.dartSource,
        contains('motion: const MotionTokens(enabled: false)'),
      );
      await tester.tap(motionRow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(docsState.themeModel.document.motionEnabled, isTrue);
      expect(
        docsState.themeModel.dartSource,
        contains('motion: const MotionTokens()'),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('the theming page documents motion', (
      WidgetTester tester,
    ) async {
      final delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/theming');
      expect(find.text('Motion'), findsWidgets);
      expect(find.textContaining('instant 100 ms'), findsWidgets);
      expect(find.textContaining('MediaQuery.disableAnimations'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}

/// The decoded neutral preset JSON for the rejection test.
Map<String, Object?> _neutralJson() =>
    jsonDecode(kPresetSources['neutral']!.json) as Map<String, Object?>;
