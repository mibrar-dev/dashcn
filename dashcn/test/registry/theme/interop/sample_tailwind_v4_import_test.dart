// Sample Tailwind v4 import test: the theme-import sample
// (`fixtures/sample_tailwind_theme.css`: `:root` + `.dark`, `@theme inline`,
// shadows, tracking, radius, spacing, Orbitron/Rajdhani/Fira Code) parses
// with every light and dark variable either mapped or listed as unused —
// never silently dropped.

import 'dart:io';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

String _sample() => File(
  'test/registry/theme/interop/fixtures/sample_tailwind_theme.css',
).readAsStringSync();

/// Every `--variable` declared in the `:root` / `.dark` block of [source].
Set<String> _declaredVars(String source, String blockSelector) {
  final RegExp block = RegExp(
    '${RegExp.escape(blockSelector)}\\s*\\{([^}]*)\\}',
    dotAll: true,
  );
  final RegExpMatch? match = block.firstMatch(source);
  if (match == null) {
    return <String>{};
  }
  return RegExp(r'--([A-Za-z0-9-]+)\s*:')
      .allMatches(match.group(1)!)
      .map((RegExpMatch m) => '--${m.group(1)}')
      .toSet();
}

void main() {
  group('sample tailwind v4 theme', () {
    late String source;
    late CssThemeResult result;
    setUpAll(() {
      source = _sample();
      result = parseCssTheme(source);
    });

    test('detects the v4 colour era', () {
      expect(result.variant, CssVariant.v4);
    });

    test('every :root and .dark variable is mapped or listed as unused', () {
      final Set<String> declared = <String>{
        ..._declaredVars(source, ':root'),
        ..._declaredVars(source, '.dark'),
      };
      expect(declared, isNotEmpty);
      final Set<String> covered = <String>{
        for (final MappedEntry e in result.report.mapped) e.variable,
        for (final IgnoredEntry e in result.report.ignored) e.variable,
      };
      expect(declared.difference(covered), isEmpty);
    });

    test('light and dark colours stay in their own mode', () {
      // :root background is purple-ish, .dark background is near-black.
      expect(result.theme.light['background'], isNot(0xFF000000));
      expect(
        result.theme.dark['background'],
        isNot(result.theme.light['background']),
      );
      expect(result.theme.light['primary'], result.theme.dark['primary']);
      expect(result.theme.light['chart1'], result.theme.dark['chart1']);
    });

    test('maps fonts, radius, spacing and tracking', () {
      expect(result.theme.fonts['sans'], contains('Orbitron'));
      expect(result.theme.fonts['serif'], contains('Rajdhani'));
      expect(result.theme.fonts['mono'], contains('Fira Code'));
      expect(result.theme.radius, 0);
      expect(result.theme.spacing, 0.25);
      expect(result.theme.tracking['normal'], 0.1);
    });

    test('maps shadow atoms per mode, including the x/y aliases', () {
      final WebShadowAtoms light = result.theme.lightShadow!;
      expect(light.blur, 12);
      expect(light.spread, 2);
      expect(light.offsetX, 0);
      expect(light.offsetY, 0);
      expect(light.opacity, 0.6);
      final WebShadowAtoms dark = result.theme.darkShadow!;
      expect(dark.blur, 20);
      expect(dark.spread, 4);
      expect(dark.opacity, 0.8);
      expect(dark.color, isNot(light.color));
    });

    test('lists derived shadow sizes as unused, never silent', () {
      final Map<String, String> ignored = <String, String>{
        for (final IgnoredEntry e in result.report.ignored)
          e.variable: e.reason,
      };
      for (final String size in <String>[
        '--shadow-2xs',
        '--shadow-xs',
        '--shadow-sm',
        '--shadow',
        '--shadow-md',
        '--shadow-lg',
        '--shadow-xl',
        '--shadow-2xl',
      ]) {
        expect(
          ignored[size],
          contains('recomputed from shadow atoms'),
          reason: size,
        );
      }
    });

    test('reports directives and build-time helpers with clear lines', () {
      final Map<String, String> ignored = <String, String>{
        for (final IgnoredEntry e in result.report.ignored)
          e.variable: e.reason,
      };
      expect(ignored['@import "tailwindcss"'], contains('not a theme token'));
      expect(
        ignored['@custom-variant dark (&:is(.dark *))'],
        contains('.dark block'),
      );
      expect(ignored['@layer base'], contains('still parsed'));
      expect(
        ignored['@apply border-border outline-ring/50'],
        contains('not a theme token'),
      );
      expect(
        ignored['@apply bg-background text-foreground'],
        contains('not a theme token'),
      );
    });

    test('resolves @theme var() references instead of dropping them', () {
      final Set<String> mapped = <String>{
        for (final MappedEntry e in result.report.mapped) e.variable,
      };
      expect(mapped, contains('--color-background'));
      expect(mapped, contains('--color-sidebar-ring'));
    });
  });
}
