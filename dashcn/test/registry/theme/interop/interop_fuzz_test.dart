// Fuzz gate: random and garbage input never throws and always returns a
// completed theme plus a report (seeded for determinism).

import 'dart:math';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

const List<String> _alphabet = <String>[
  '{',
  '}',
  ':',
  ';',
  '(',
  ')',
  ',',
  '.',
  '%',
  '#',
  '-',
  '_',
  ' ',
  '\n',
  'a',
  'Z',
  '0',
  '9',
  '--',
  'var',
  'oklch',
  'hsl',
  'root',
  'dark',
  '@theme',
  'color',
  'radius',
  'undefined',
  'null',
  '"',
  "'",
];

String _randomCss(Random random) {
  final StringBuffer out = StringBuffer();
  final int parts = random.nextInt(12);
  for (int i = 0; i < parts; i++) {
    out.write(_alphabet[random.nextInt(_alphabet.length)]);
    if (random.nextBool()) {
      out.write(random.nextInt(1000));
    }
  }
  return out.toString();
}

String _mutate(String source, Random random) {
  if (source.isEmpty || random.nextBool()) {
    return _randomCss(random);
  }
  final int at = random.nextInt(source.length);
  final int end = (at + random.nextInt(8)).clamp(0, source.length);
  const String inject = '{};:(),%#--var()';
  return source.substring(0, at) +
      inject[random.nextInt(inject.length)] +
      source.substring(end);
}

const String _validCss = '''
:root {
  --background: oklch(1 0 0);
  --primary: 222.2 47.4% 11.2%;
  --radius: 0.625rem;
  --font-sans: Inter, sans-serif;
}
.dark {
  --background: oklch(0.145 0 0);
  --primary: oklch(0.922 0 0);
}
@theme inline {
  --color-background: var(--background);
}
''';

const String _validJs = '''
module.exports = { theme: { extend: { colors: {
  primary: { DEFAULT: "hsl(var(--primary))" },
  border: "#e5e5e5",
} } } };
''';

void _checkComplete(WebTheme theme) {
  expect(theme.light.length, 32);
  expect(theme.dark.length, 32);
  expect(theme.radius, isNotNull);
  expect(theme.spacing, isNotNull);
  expect(theme.tracking['normal'], isNotNull);
  expect(theme.lightShadow, isNotNull);
  expect(theme.darkShadow, isNotNull);
}

void main() {
  test('css fuzz never throws and always completes', () {
    final Random random = Random(20261012);
    for (int i = 0; i < 300; i++) {
      final String input = i.isEven
          ? _randomCss(random)
          : _mutate(_validCss, random);
      final CssThemeResult result = parseCssTheme(input);
      _checkComplete(result.theme);
      expect(
        result.report.mapped.length +
            result.report.defaulted.length +
            result.report.ignored.length,
        greaterThan(0),
      );
    }
  });

  test('tailwind v3 fuzz never throws and always completes', () {
    final Random random = Random(4211);
    for (int i = 0; i < 300; i++) {
      final String input = i.isEven
          ? _randomCss(random)
          : _mutate(_validJs, random);
      final TailwindV3Result result = parseTailwindV3Theme(input);
      _checkComplete(result.theme);
    }
  });

  test('colour fuzz never throws the nullable parser', () {
    final Random random = Random(77);
    for (int i = 0; i < 500; i++) {
      expect(() => tryParseWebColor(_randomCss(random)), returnsNormally);
    }
  });
}
