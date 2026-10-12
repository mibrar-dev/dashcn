// Writer tests: Tailwind v4 output re-parses losslessly, DTCG output is a
// valid token document with both modes, and the CSS writer shape is stable.

import 'dart:convert';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

WebTheme _sample() => WebTheme(
  light: <String, int>{
    for (final String token in kKitColorTokens) token: 0xFFFFFFFF,
  },
  dark: <String, int>{
    for (final String token in kKitColorTokens) token: 0xFF000000,
  },
  radius: 0.5,
  fonts: const <String, String>{'sans': 'Inter, sans-serif'},
  spacing: 0.25,
  tracking: const <String, double>{'normal': 0},
  lightShadow: WebShadowAtoms.fallback,
  darkShadow: WebShadowAtoms.fallback,
);

void main() {
  group('web css writer', () {
    test('emits selectors, colours and scalars', () {
      final String css = writeWebCss(_sample());
      expect(css, startsWith(':root {\n'));
      expect(css, contains('--primary: oklch(1 0 0);'));
      expect(css, contains('--radius: 0.5rem;'));
      expect(css, contains('--font-sans: Inter, sans-serif;'));
      expect(css, contains('--spacing: 0.25rem;'));
      expect(css, contains('--tracking-normal: 0em;'));
      expect(css, contains('--shadow-blur: 3px;'));
      expect(css, contains('.dark {\n'));
      expect(css, endsWith('}\n'));
    });

    test('completes partial themes before writing', () {
      final String css = writeWebCss(const WebTheme());
      final CssThemeResult back = parseCssTheme(css);
      expect(back.report.defaulted, isEmpty);
      expect(back.report.ignored, isEmpty);
    });
  });

  group('tailwind v4 writer', () {
    test('aliases re-parse to the same theme', () {
      final WebTheme theme = _sample();
      final String css = writeTailwindV4Theme(theme);
      expect(css, contains('@theme inline {\n'));
      expect(css, contains('--color-primary: var(--primary);'));
      expect(css, contains('--font-sans: var(--font-sans);'));
      expect(css, contains('--radius-lg: var(--radius);'));
      final CssThemeResult back = parseCssTheme(css);
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
      expect(back.theme.fonts['sans'], 'Inter, sans-serif');
      expect(back.theme.radius, 0.5);
    });
  });

  group('dtcg writer', () {
    test('emits colours with light/dark modes plus scalars', () {
      final Map<String, Object?> document =
          jsonDecode(writeDtcgTokens(_sample(), id: 'demo'))
              as Map<String, Object?>;
      final Map<String, Object?> demo =
          document['demo'] as Map<String, Object?>;
      final Map<String, Object?> colors = demo['color'] as Map<String, Object?>;
      expect(colors.length, 32);
      final Map<String, Object?> primary =
          colors['primary'] as Map<String, Object?>;
      expect(primary[r'$value'], '#FFFFFF');
      expect(primary[r'$type'], 'color');
      final Map<String, Object?> modes =
          (primary[r'$extensions'] as Map)['mode'] as Map<String, Object?>;
      expect(modes['light'], '#FFFFFF');
      expect(modes['dark'], '#000000');
      final Map<String, Object?> radius =
          demo['radius'] as Map<String, Object?>;
      expect(radius[r'$value'], '8.0px');
      final Map<String, Object?> font =
          (demo['font'] as Map)['sans'] as Map<String, Object?>;
      expect(font[r'$value'], 'Inter, sans-serif');
      final Map<String, Object?> shadow =
          (demo['shadow'] as Map)['light'] as Map<String, Object?>;
      expect((shadow['color'] as Map)[r'$value'], '#000000');
    });
  });

  group('preset json writer', () {
    test('output validates field-wise', () {
      final Map<String, Object?> json = presetJsonFromWebTheme(
        _sample(),
        id: 'demo',
        name: 'Demo',
      );
      expect(json['schemaVersion'], 2);
      expect((json['light'] as Map).length, 32);
      expect((json['dark'] as Map).length, 32);
      expect(json['radius'], 0.5);
      expect(json['fonts'], <String, Object?>{'sans': 'Inter, sans-serif'});
      // Strict reader accepts writer output.
      expect(webThemeFromPresetJson(json).radius, 0.5);
    });

    test('strict reader rejects malformed documents', () {
      expect(
        () => webThemeFromPresetJson(<String, Object?>{}),
        throwsA(isA<WebThemeException>()),
      );
      expect(
        () => webThemeFromPresetJson(<String, Object?>{
          'schemaVersion': 2,
          'light': <String, Object?>{},
          'dark': <String, Object?>{},
          'radius': 0.5,
          'spacing': 0.25,
          'tracking': <String, Object?>{'normal': 0},
          'shadow': <String, Object?>{
            'light': <String, Object?>{},
            'dark': <String, Object?>{},
          },
        }),
        throwsA(isA<WebThemeException>()),
      );
    });
  });
}
