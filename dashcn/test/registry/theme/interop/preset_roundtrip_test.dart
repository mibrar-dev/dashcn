// Round-trip gate over every preset: preset JSON → [WebTheme] → v4 CSS →
// parse stays within ΔE2000 < 0.5 per colour and exact for radius, fonts,
// spacing, tracking and shadow atoms. Also pins the preset-JSON writer.

import 'dart:convert';
import 'dart:io';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

String get _themesDir => '${Directory.current.path}/lib/src/themes';

List<File> _presetFiles() =>
    Directory(_themesDir)
        .listSync()
        .whereType<File>()
        .where(
          (File file) =>
              file.path.endsWith('.json') &&
              !file.path.endsWith('index.json') &&
              !file.path.endsWith('themes.schema.json'),
        )
        .toList()
      ..sort((File a, File b) => a.path.compareTo(b.path));

Map<String, Object?> _readJson(File file) =>
    jsonDecode(file.readAsStringSync()) as Map<String, Object?>;

void main() {
  final List<File> files = _presetFiles();

  test('all presets are covered', () {
    expect(files.length, 43);
    expect(kKitColorTokens.length, 32);
  });

  test('token inventory matches the schema and the fallbacks', () {
    final Map<String, Object?> schema = _readJson(
      File('$_themesDir/themes.schema.json'),
    );
    final Map<String, Object?> defs = schema[r'$defs'] as Map<String, Object?>;
    final List<Object?> required =
        (defs['colorMap'] as Map)['required'] as List<Object?>;
    expect(kKitColorTokens, required.cast<String>());
    expect(kFallbackLight.keys.toSet(), kKitColorTokens.toSet());
    expect(kFallbackDark.keys.toSet(), kKitColorTokens.toSet());
    for (final String token in kKitColorTokens) {
      expect(kitTokenToCssVar(token), isNotNull, reason: token);
      expect(cssVarToKitToken(kitTokenToCssVar(token)!), token);
    }
  });

  for (final File file in files) {
    final String id = file.path.split('/').last.replaceAll('.json', '');
    group('preset $id', () {
      late WebTheme theme;
      late CssThemeResult back;
      setUpAll(() {
        theme = webThemeFromPresetJson(_readJson(file));
        back = parseCssTheme(writeWebCss(theme));
      });

      test('colours round-trip within dE2000 < 0.5', () {
        for (final String token in kKitColorTokens) {
          expect(
            deltaE2000(theme.light[token]!, back.theme.light[token]!),
            lessThan(0.5),
            reason: 'light.$token',
          );
          expect(
            deltaE2000(theme.dark[token]!, back.theme.dark[token]!),
            lessThan(0.5),
            reason: 'dark.$token',
          );
        }
      });

      test('scalars round-trip exactly', () {
        expect(back.theme.radius, theme.radius);
        expect(back.theme.fonts, theme.fonts);
        expect(back.theme.spacing, theme.spacing);
        expect(back.theme.tracking, theme.tracking);
        for (final bool isDark in <bool>[false, true]) {
          final WebShadowAtoms a = (isDark
              ? theme.darkShadow
              : theme.lightShadow)!;
          final WebShadowAtoms b = (isDark
              ? back.theme.darkShadow
              : back.theme.lightShadow)!;
          expect(deltaE2000(a.color, b.color), lessThan(0.5));
          expect(b.opacity, moreOrLessEquals(a.opacity));
          expect(b.blur, moreOrLessEquals(a.blur));
          expect(b.spread, moreOrLessEquals(a.spread));
          expect(b.offsetX, moreOrLessEquals(a.offsetX));
          expect(b.offsetY, moreOrLessEquals(a.offsetY));
        }
      });

      test('report is clean and the era is v4', () {
        expect(back.variant, CssVariant.v4);
        expect(back.report.defaulted, isEmpty, reason: id);
        expect(back.report.ignored, isEmpty, reason: id);
      });

      test('preset JSON writer round-trips the document', () {
        final Map<String, Object?> json = _readJson(file);
        final Map<String, Object?> written = presetJsonFromWebTheme(
          theme,
          id: id,
          name: json['name']! as String,
        );
        final WebTheme reread = webThemeFromPresetJson(written);
        expect(reread.light, theme.light);
        expect(reread.dark, theme.dark);
        expect(reread.radius, theme.radius);
        expect(reread.fonts, theme.fonts);
        expect(reread.spacing, theme.spacing);
        expect(reread.tracking, theme.tracking);
      });
    });
  }
}
