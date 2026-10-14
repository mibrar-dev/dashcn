// Tailwind v3 literal-parser cases: nesting, quotes, comments, references,
// and graceful handling of everything that is not a literal.

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:dashcn/src/theme/interop/internal/css_mapping.dart';
import 'package:flutter_test/flutter_test.dart';

const Map<String, String> _vars = <String, String>{
  'primary': '222.2 47.4% 11.2%',
  'background': '0 0% 100%',
};

TailwindV3Result _parse(
  String source, {
  Map<String, String> lightVars = _vars,
  Map<String, String> darkVars = const <String, String>{},
}) => parseTailwindV3Theme(source, lightVars: lightVars, darkVars: darkVars);

void main() {
  group('v3PathToKitToken', () {
    test('single names, DEFAULT and nested pairs', () {
      expect(v3PathToKitToken(<String>['border']), 'border');
      expect(v3PathToKitToken(<String>['primary', 'DEFAULT']), 'primary');
      expect(
        v3PathToKitToken(<String>['primary', 'foreground']),
        'primaryForeground',
      );
      expect(
        v3PathToKitToken(<String>['sidebar', 'primary-foreground']),
        'sidebarPrimaryForeground',
      );
      expect(v3PathToKitToken(<String>['chart', '3']), 'chart3');
      expect(v3PathToKitToken(<String>['chart', '9']), isNull);
      expect(v3PathToKitToken(<String>['brand', '500']), isNull);
      expect(v3PathToKitToken(<String>[]), isNull);
    });
  });

  group('literals', () {
    test('reads theme.extend.colors with comments and quotes', () {
      const String source = '''
        // leading comment
        module.exports = {
          theme: { extend: { colors: {
            /* block */ border: "#e5e5e5", // trailing
            'primary': { DEFAULT: "#0f172a", 'foreground': "#f8fafc", },
            slate: { 50: '#f8fafc', 900: '#0f172a', },
          } } },
        };
      ''';
      final TailwindV3Result result = _parse(source);
      expect(result.theme.light['border'], 0xFFE5E5E5);
      expect(result.theme.light['primary'], 0xFF0F172A);
      expect(result.theme.light['primaryForeground'], 0xFFF8FAFC);
      final Set<String> ignored = <String>{
        for (final IgnoredEntry e in result.report.ignored) e.variable,
      };
      expect(ignored, <String>{'slate.50', 'slate.900'});
    });

    test('accepts a bare colors object', () {
      final TailwindV3Result result = _parse('{ colors: { border: "red" } }');
      expect(result.theme.light['border'], 0xFFFF0000);
    });

    test('resolves hsl(var(--x)) per mode', () {
      const String source = '''
        { theme: { extend: { colors: {
          primary: 'hsl(var(--primary))',
          background: 'hsl(var(--background))',
        } } } }
      ''';
      final TailwindV3Result result = _parse(
        source,
        darkVars: <String, String>{
          'primary': '210 40% 98%',
          'background': '222.2 84% 4.9%',
        },
      );
      expect(result.theme.light['primary'], 0xFF0F172A);
      expect(result.theme.dark['primary'], 0xFFF8FAFC);
      expect(result.theme.light['background'], 0xFFFFFFFF);
      expect(result.theme.dark['background'], 0xFF020817);
    });

    test('var() fallbacks fill both modes', () {
      final TailwindV3Result result = _parse(
        '{ colors: { ring: "hsl(var(--nope, 0 0% 50%))" } }',
      );
      expect(result.theme.light['ring'], 0xFF808080);
      expect(result.theme.dark['ring'], 0xFF808080);
    });
  });

  group('non-literals never evaluate', () {
    test('arrays, numbers, calls and member access are ignored', () {
      const String source = '''
        { theme: { extend: { colors: {
          overlay: ["rgba(0,0,0,0.5)"],
          width: 8,
          brand: colors.slate,
          glow: rgb(255, 0, 0),
          tagged: `hsl(var(--primary))`,
        } } } }
      ''';
      final TailwindV3Result result = _parse(source);
      expect(result.report.mapped, isEmpty);
      final Set<String> ignored = <String>{
        for (final IgnoredEntry e in result.report.ignored) e.variable,
      };
      expect(ignored, <String>{'overlay', 'width', 'brand', 'glow', 'tagged'});
      // Completion still fills every token.
      expect(result.theme.light.length, 32);
      expect(result.theme.dark.length, 32);
    });

    test('garbage recovers with a report instead of throwing', () {
      for (final String source in <String>[
        '',
        '((((',
        'module.exports = 42;',
        '{ theme: { extend: { colors: { broken: ',
        'not js at all {{{ }}}',
        '{ colors: { spread: { ...base, extra: "#fff" } } }',
      ]) {
        final TailwindV3Result result = _parse(source);
        expect(result.theme.light.length, 32);
        expect(result.theme.dark.length, 32);
        expect(result.report.ignored, isNotEmpty);
      }
    });
  });
}
