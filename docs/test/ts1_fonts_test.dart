// P7-TS1 bug 3: heading/body fonts apply site-wide, install cleanly, and
// the catalogue matches the declared bundle.
//
// `Heading font` drives h1–h4/large, `Body font` drives the ambient `sans`
// (which every familyless style inherits through `DashcnApp`'s
// `DefaultTextStyle`), and the generated `app_theme.dart` maps the Studio
// slots onto real `ThemeFonts` parameters (`body` wins for `fontSans`).

import 'package:docs/state/docs_state.dart';
import 'package:docs/theme/docs_fonts.dart';
import 'package:docs/theme/theme_dart_source.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/theme/theme_document_edits.dart';
import 'package:docs/theme/theme_export.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  group('font slots apply site-wide', () {
    test('a heading pick drives h1-h4 and large only', () {
      final ThemeData theme = ThemeDocument.fromPreset(
        'neutral',
      ).withFont('heading', 'Playfair Display').theme(Brightness.light);
      for (final TextStyle style in <TextStyle>[
        theme.typography.h1,
        theme.typography.h2,
        theme.typography.h3,
        theme.typography.h4,
        theme.typography.large,
      ]) {
        expect(style.fontFamily, 'Playfair Display');
      }
      expect(theme.typography.sans.fontFamily, 'Geist');
      expect(theme.typography.base.fontFamily, isNull);
    });

    test('a body pick drives the ambient sans the site inherits', () {
      final ThemeData theme = ThemeDocument.fromPreset(
        'neutral',
      ).withFont('body', 'Inter').theme(Brightness.light);
      expect(theme.typography.sans.fontFamily, 'Inter');
      expect(theme.typography.h1.fontFamily, isNot('Inter'));
      expect(theme.fonts.fontSans, 'Inter');
    });

    test('clearing the slots restores the preset families', () {
      final ThemeData theme = ThemeDocument.fromPreset('neutral')
          .withFont('heading', null)
          .withFont('body', null)
          .theme(Brightness.light);
      expect(theme.typography.sans.fontFamily, 'Geist');
      expect(theme.typography.h1.fontFamily, isNull);
    });

    test('mono still drives mono and inline code', () {
      final ThemeData theme = ThemeDocument.fromPreset(
        'neutral',
      ).withFont('mono', 'JetBrains Mono').theme(Brightness.light);
      expect(theme.typography.mono.fontFamily, 'JetBrains Mono');
      expect(theme.typography.inlineCode.fontFamily, 'JetBrains Mono');
    });

    test('a font-less document keeps the bundled Geist look', () {
      final ThemeData theme = ThemeDocument.fromPreset('neutral')
          .withFont('sans', null)
          .withFont('body', null)
          .withFont('mono', null)
          .theme(Brightness.light);
      expect(theme.typography.sans.fontFamily, 'GeistSans');
      expect(theme.typography.sans.fontFamilyFallback, <String>[
        'NotoSansSymbols2',
      ]);
      expect(theme.typography.mono.fontFamily, 'GeistMono');
    });

    test('heading/body fonts survive the JSON round-trip', () {
      final ThemeDocument document = ThemeDocument.fromPreset(
        'neutral',
      ).withFont('heading', 'Playfair Display').withFont('body', 'Inter');
      final ThemeDocument back = ThemeDocument.fromJson(document.toJson());
      expect(back.headingFont, 'Playfair Display');
      expect(back.bodyFont, 'Inter');
      expect(back.json, document.json);
    });
  });

  group('font codegen stays compilable', () {
    test('heading+body emit fontSans/fontHeading, never fontBody', () {
      final String rendered = themeDartSource(
        ThemeDocument.fromPreset(
          'neutral',
        ).withFont('heading', 'Playfair Display').withFont('body', 'Inter'),
      );
      expect(rendered, contains("fontSans: 'Inter'"));
      expect(rendered, contains("fontHeading: 'Playfair Display'"));
      expect(rendered, isNot(contains('fontBody')));
      expect(rendered, isNot(contains('fontSans: \'Geist, sans-serif\'')));
    });

    test('presets without heading/body render exactly as before', () {
      final String rendered = themeDartSource(
        ThemeDocument.fromPreset('neutral'),
      );
      expect(rendered, contains("fontSans: 'Geist, sans-serif'"));
      expect(rendered, isNot(contains('fontHeading')));
    });

    test('the CLI tab prints no font section for untouched presets', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      expect(
        themePubspecSnippet(state.themeModel.document),
        isNull,
        reason: 'presets never set heading/body, so there is nothing to bundle',
      );
      expect(
        themeCliGuide(state.themeModel.document),
        isNot(contains('pubspec')),
      );
    });

    test('the CLI tab prints the pubspec steps for a picked family', () {
      final DocsState state = DocsState(storage: MemoryDocsStorage());
      addTearDown(state.dispose);
      state.themeModel.setFont('body', 'Inter');
      state.themeModel.setFont('heading', 'Playfair Display');
      final String? snippet = themePubspecSnippet(state.themeModel.document);
      expect(snippet, isNotNull);
      expect(snippet, contains('family: Inter'));
      expect(snippet, contains('assets/fonts/Inter-Regular.ttf'));
      expect(snippet, contains('family: Playfair Display'));
      expect(
        themeCliGuide(state.themeModel.document),
        contains('family: Inter'),
      );
    });
  });

  group('font catalogue matches the bundle', () {
    test('every catalogue entry is well formed', () {
      for (final DocsFontFamily entry in <DocsFontFamily>[
        ...kDocsHeadingFonts,
        ...kDocsBodyFonts,
        ...kDocsMonoFonts,
      ]) {
        if (entry.label == 'Default') {
          expect(entry.family, isEmpty);
          expect(entry.assets, isEmpty);
          continue;
        }
        expect(entry.family, isNotEmpty);
        for (final String asset in entry.assets) {
          expect(asset, startsWith('assets/fonts/'));
          expect(asset, endsWith('.ttf'));
        }
      }
    });

    test('loader-free entries are the bundled Geist aliases only', () {
      for (final DocsFontFamily entry in <DocsFontFamily>[
        ...kDocsHeadingFonts,
        ...kDocsBodyFonts,
        ...kDocsMonoFonts,
      ]) {
        if (entry.assets.isEmpty && entry.family.isNotEmpty) {
          expect(
            entry.family,
            anyOf('GeistSans', 'GeistMono'),
            reason: '${entry.label} must resolve without a FontLoader call',
          );
        }
      }
    });

    testWidgets('a picked family loads through FontLoader', (tester) async {
      expect(docsFontLoaded('Inter'), isFalse);
      await loadDocsFonts('Inter');
      expect(docsFontLoaded('Inter'), isTrue);
      await loadDocsFonts('Inter');
      expect(docsFontLoaded('Inter'), isTrue);
    });
  });
}
