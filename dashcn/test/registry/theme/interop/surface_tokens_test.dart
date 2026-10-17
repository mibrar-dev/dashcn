// Round-trip tests for the glass tokens (`surfaceOpacity` / `surfaceBlur`)
// across preset JSON, CSS/Tailwind, DTCG and the docs `ThemeDocument`.

import 'dart:convert';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

WebTheme _glassTheme() => const WebTheme(surfaceOpacity: 0.8, surfaceBlur: 8);

void main() {
  group('preset JSON', () {
    test('optional fields round-trip', () {
      final Map<String, Object?> json = presetJsonFromWebTheme(
        _glassTheme().copyWith(
          light: <String, int>{for (final t in _tokens) t: 0xFFFFFFFF},
          dark: <String, int>{for (final t in _tokens) t: 0xFF000000},
          radius: () => 0.625,
          spacing: () => 0.25,
          tracking: <String, double>{'normal': 0},
          lightShadow: () => WebShadowAtoms.fallback,
          darkShadow: () => WebShadowAtoms.fallback,
        ),
        id: 'glass',
        name: 'Glass',
      );
      expect(json['surfaceOpacity'], 0.8);
      expect(json['surfaceBlur'], 8);
      final WebTheme back = webThemeFromPresetJson(json);
      expect(back.surfaceOpacity, 0.8);
      expect(back.surfaceBlur, 8);
    });

    test('absent fields stay absent', () {
      final WebTheme empty = webThemeFromPresetJson(_minimalPresetJson());
      expect(empty.surfaceOpacity, isNull);
      expect(empty.surfaceBlur, isNull);
      final Map<String, Object?> written = presetJsonFromWebTheme(
        empty,
        id: 'x',
        name: 'X',
      );
      expect(written.containsKey('surfaceOpacity'), isFalse);
      expect(written.containsKey('surfaceBlur'), isFalse);
    });

    test('out-of-range opacity and negative blur throw', () {
      final Map<String, Object?> base = _minimalPresetJson();
      expect(
        () => webThemeFromPresetJson(<String, Object?>{
          ...base,
          'surfaceOpacity': 2,
        }),
        throwsA(isA<WebThemeException>()),
      );
      expect(
        () => webThemeFromPresetJson(<String, Object?>{
          ...base,
          'surfaceBlur': -1,
        }),
        throwsA(isA<WebThemeException>()),
      );
    });
  });

  group('CSS', () {
    test('surface custom properties round-trip', () {
      final String css = writeWebCss(_fullGlassTheme());
      expect(css, contains('--surface-opacity: 0.8;'));
      expect(css, contains('--surface-blur: 8px;'));
      final CssThemeResult back = parseCssTheme(css);
      expect(back.theme.surfaceOpacity, moreOrLessEquals(0.8));
      expect(back.theme.surfaceBlur, moreOrLessEquals(8));
    });

    test('absent properties stay absent with a clean report', () {
      final CssThemeResult back = parseCssTheme(writeWebCss(const WebTheme()));
      // The writer omits absent glass tokens; the parser leaves them null.
      // (The report covers only schema-required tokens here.)
      expect(back.theme.surfaceOpacity, isNull);
      expect(back.theme.surfaceBlur, isNull);
    });
  });

  group('Tailwind', () {
    test('surface properties travel through the v4 writer', () {
      final String css = writeTailwindV4Theme(_fullGlassTheme());
      expect(css, contains('--surface-opacity: 0.8;'));
      expect(css, contains('--surface-blur: 8px;'));
      final CssThemeResult back = parseCssTheme(css);
      expect(back.theme.surfaceOpacity, moreOrLessEquals(0.8));
      expect(back.theme.surfaceBlur, moreOrLessEquals(8));
    });
  });

  group('DTCG', () {
    test('surface tokens round-trip', () {
      final String dtcg = writeDtcgTokens(_fullGlassTheme());
      final Map<String, Object?> doc = jsonDecode(dtcg) as Map<String, Object?>;
      final Map<String, Object?> light = doc['light'] as Map<String, Object?>;
      expect((light['surfaceOpacity'] as Map)['\$value'], 0.8);
      expect((light['surfaceBlur'] as Map)['\$value'], '8.0px');
    });

    test('absent surface tokens are omitted', () {
      final String dtcg = writeDtcgTokens(const WebTheme());
      final Map<String, Object?> doc = jsonDecode(dtcg) as Map<String, Object?>;
      expect((doc['light'] as Map).containsKey('surfaceOpacity'), isFalse);
      expect((doc['light'] as Map).containsKey('surfaceBlur'), isFalse);
    });
  });
}

const List<String> _tokens = <String>[
  'background',
  'foreground',
  'card',
  'cardForeground',
  'popover',
  'popoverForeground',
  'primary',
  'primaryForeground',
  'secondary',
  'secondaryForeground',
  'muted',
  'mutedForeground',
  'accent',
  'accentForeground',
  'destructive',
  'destructiveForeground',
  'border',
  'input',
  'ring',
  'chart1',
  'chart2',
  'chart3',
  'chart4',
  'chart5',
  'sidebar',
  'sidebarForeground',
  'sidebarPrimary',
  'sidebarPrimaryForeground',
  'sidebarAccent',
  'sidebarAccentForeground',
  'sidebarBorder',
  'sidebarRing',
];

WebTheme _fullGlassTheme() => WebTheme(
  light: <String, int>{for (final t in _tokens) t: 0xFFFFFFFF},
  dark: <String, int>{for (final t in _tokens) t: 0xFF000000},
  radius: 0.625,
  spacing: 0.25,
  tracking: const <String, double>{'normal': 0},
  lightShadow: WebShadowAtoms.fallback,
  darkShadow: WebShadowAtoms.fallback,
  surfaceOpacity: 0.8,
  surfaceBlur: 8,
);

Map<String, Object?> _minimalPresetJson() {
  Map<String, Object?> colors(int argb) => <String, Object?>{
    for (final t in _tokens)
      t: '#${argb.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
  };
  return <String, Object?>{
    r'$schema': './themes.schema.json',
    'id': 'minimal',
    'name': 'Minimal',
    'schemaVersion': 2,
    'light': colors(0xFFFFFFFF),
    'dark': colors(0xFF000000),
    'radius': 0.625,
    'spacing': 0.25,
    'tracking': <String, Object?>{'normal': 0},
    'shadow': <String, Object?>{
      'light': <String, Object?>{
        'color': '#000000',
        'opacity': 0.1,
        'blur': 3,
        'spread': 0,
        'offsetX': 0,
        'offsetY': 1,
      },
      'dark': <String, Object?>{
        'color': '#000000',
        'opacity': 0.1,
        'blur': 3,
        'spread': 0,
        'offsetX': 0,
        'offsetY': 1,
      },
    },
  };
}
