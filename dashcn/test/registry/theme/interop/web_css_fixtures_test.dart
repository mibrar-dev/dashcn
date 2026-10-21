// Fixture tests: five real-world-format themes (v3 variables, v4 variables,
// tweakcn-style export, Tailwind v4 @theme, Tailwind v3 config) parse to the
// expected tokens with honest reports.

import 'dart:io';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:dashcn/src/theme/interop/internal/color_format.dart';
import 'package:flutter_test/flutter_test.dart';

String _fixture(String name) =>
    File('test/registry/theme/interop/fixtures/$name').readAsStringSync();

const Map<String, String> _v3Vars = <String, String>{
  'border': '214.3 31.8% 91.4%',
  'input': '214.3 31.8% 91.4%',
  'background': '0 0% 100%',
  'foreground': '222.2 84% 4.9%',
  'primary': '222.2 47.4% 11.2%',
  'primary-foreground': '210 40% 98%',
  'secondary': '210 40% 96.1%',
  'secondary-foreground': '222.2 47.4% 11.2%',
  'destructive': '0 84.2% 60.2%',
  'destructive-foreground': '210 40% 98%',
  'muted': '210 40% 96.1%',
  'muted-foreground': '215.4 16.3% 46.9%',
  'accent': '210 40% 96.1%',
  'accent-foreground': '222.2 47.4% 11.2%',
  'popover': '0 0% 100%',
  'popover-foreground': '222.2 84% 4.9%',
  'card': '0 0% 100%',
  'card-foreground': '222.2 84% 4.9%',
  'chart-1': '12 76% 61%',
  'chart-2': '173 58% 39%',
  'chart-3': '197 37% 24%',
  'chart-4': '43 74% 66%',
  'chart-5': '27 87% 67%',
  'sidebar-background': '0 0% 98%',
  'sidebar-foreground': '240 5.3% 26.1%',
  'sidebar-primary': '240 5.9% 10%',
  'sidebar-primary-foreground': '0 0% 98%',
  'sidebar-accent': '240 4.8% 95.9%',
  'sidebar-accent-foreground': '240 5.9% 10%',
  'sidebar-border': '220 13% 91%',
  'sidebar-ring': '217.2 91.2% 59.8%',
};

void main() {
  group('v3 classic variables', () {
    late CssThemeResult result;
    setUpAll(() {
      result = parseCssTheme(_fixture('v3_classic.css'));
    });

    test('detects v3 and maps both modes', () {
      expect(result.variant, CssVariant.v3);
      expect(result.theme.light['primary'], 0xFF0F172A);
      expect(result.theme.dark['primary'], 0xFFF8FAFC);
      expect(result.theme.light['background'], 0xFFFFFFFF);
      expect(result.theme.dark['background'], 0xFF020817);
      expect(result.theme.radius, 0.5);
    });

    test('maps the v3 sidebar-background alias', () {
      expect(result.theme.light['sidebar'], 0xFFFAFAFA);
    });

    test('defaults only the tokens v3 never named', () {
      // `@layer base` is a transparent wrapper: one report line, and the
      // inner declarations still parse.
      expect(
        result.report.ignored.map((IgnoredEntry e) => e.variable),
        <String>['@layer base'],
      );
      final Set<String> defaulted = <String>{
        for (final DefaultedEntry e in result.report.defaulted) e.token,
      };
      expect(defaulted, <String>{
        'spacing',
        'tracking.normal',
        'shadow.light',
        'shadow.dark',
      });
    });
  });

  group('v4 modern variables', () {
    late CssThemeResult result;
    setUpAll(() {
      result = parseCssTheme(_fixture('v4_modern.css'));
    });

    test('detects v4 and keeps translucent borders bit-exact', () {
      expect(result.variant, CssVariant.v4);
      expect(result.theme.light['background'], 0xFFFFFFFF);
      expect(result.theme.dark['border'], 0x1AFFFFFF);
      expect(result.theme.dark['input'], 0x26FFFFFF);
    });

    test('reads radius and font stacks verbatim', () {
      expect(result.theme.radius, 0.625);
      expect(result.theme.fonts['sans'], '"Inter", ui-sans-serif, sans-serif');
      expect(result.report.mapped.length, 68);
      // The `@import "tailwindcss"` line is reported, never silent.
      expect(
        result.report.ignored.map((IgnoredEntry e) => e.variable),
        <String>['@import "tailwindcss"'],
      );
    });
  });

  group('tweakcn-style export', () {
    late CssThemeResult result;
    setUpAll(() {
      result = parseCssTheme(_fixture('tweakcn_style.css'));
    });

    test('reads atoms, radius, spacing and tracking', () {
      expect(result.variant, CssVariant.v4);
      expect(result.theme.radius, 0.65);
      expect(result.theme.spacing, 0.25);
      expect(result.theme.tracking['normal'], 0);
      final WebShadowAtoms atoms = result.theme.lightShadow!;
      expect(webHexOf(atoms.color), '#09090B');
      expect(atoms.opacity, 0.15);
      expect(atoms.blur, 20);
      expect(atoms.spread, -12);
      expect(atoms.offsetX, 0);
      expect(atoms.offsetY, 8);
    });

    test('defaults the partial dark atoms field-wise', () {
      expect(webHexOf(result.theme.darkShadow!.color), '#000000');
      expect(result.theme.darkShadow!.opacity, 0.3);
      expect(result.theme.darkShadow!.blur, WebShadowAtoms.fallback.blur);
      final Set<String> defaulted = <String>{
        for (final DefaultedEntry e in result.report.defaulted) e.token,
      };
      expect(defaulted, <String>{
        'shadow.dark.blur',
        'shadow.dark.spread',
        'shadow.dark.offsetX',
        'shadow.dark.offsetY',
      });
    });

    test('ignores derived shadows, steps, aliases and knobs with reasons', () {
      Map<String, String> ignored() => <String, String>{
        for (final IgnoredEntry e in result.report.ignored)
          e.variable: e.reason,
      };
      final Map<String, String> reasons = ignored();
      expect(result.report.ignored.length, 16);
      expect(reasons['@import "tailwindcss"'], contains('not a theme token'));
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
          reasons[size],
          contains('recomputed from shadow atoms'),
          reason: size,
        );
      }
      expect(reasons['--radius-sm'], contains('recomputed from --radius'));
      expect(reasons['--color-red-500'], contains('palette ramp'));
      expect(reasons['--animate-accordion-down'], 'no kit token counterpart');
    });
  });

  group('tailwind v4 @theme aliases', () {
    late CssThemeResult result;
    setUpAll(() {
      result = parseCssTheme(_fixture('tailwind_v4_theme.css'));
    });

    test('resolves aliases per mode and fallbacks for missing vars', () {
      expect(result.theme.light['background'], 0xFFFFFFFF);
      expect(result.theme.dark['background'], 0xFF0A0A0A);
      // --color-chart-1: var(--chart-1) resolves against each mode.
      expect(result.theme.light['chart1'], 0xFFEC5600);
      expect(result.theme.dark['chart1'], 0xFF1447E6);
      expect(result.theme.light['ring'], 0xFF000000);
      expect(result.theme.dark['ring'], 0xFF000000);
    });

    test('keeps the self-aliased font stack, ignores the rest', () {
      expect(result.theme.fonts['sans'], '"Inter", sans-serif');
      final Set<String> ignored = <String>{
        for (final IgnoredEntry e in result.report.ignored) e.variable,
      };
      expect(ignored, <String>{
        '--color-red-500',
        '--color-accent-foreground-2',
        '--font-display',
        '--radius-lg',
        '--animate-fade',
      });
    });
  });

  group('tailwind v3 config', () {
    late TailwindV3Result result;
    setUpAll(() {
      result = parseTailwindV3Theme(
        _fixture('tailwind_v3_config.js'),
        lightVars: _v3Vars,
        darkVars: _v3Vars,
      );
    });

    test('maps nested shades, DEFAULT keys and numeric chart keys', () {
      expect(result.report.mapped.length, 32);
      expect(result.theme.light['primary'], 0xFF0F172A);
      expect(result.theme.light['primaryForeground'], 0xFFF8FAFC);
      expect(result.theme.light['chart3'], 0xFF274754);
      expect(result.theme.light['sidebarPrimary'], 0xFF18181B);
      expect(result.theme.light['sidebarPrimaryForeground'], 0xFFFAFAFA);
    });

    test('uses var() fallbacks and ignores non-literals with reasons', () {
      expect(result.theme.light['ring'], 0xFF808080);
      expect(result.theme.dark['ring'], 0xFF808080);
      final Map<String, String> ignored = <String, String>{
        for (final IgnoredEntry e in result.report.ignored)
          e.variable: e.reason,
      };
      expect(ignored.length, 6);
      expect(ignored['brand.500'], 'not a kit colour token');
      expect(ignored['static'], 'not a kit colour token');
      expect(ignored['overlay'], contains('no JS evaluation'));
      expect(ignored['ringWidth'], contains('no JS evaluation'));
      final Set<String> defaulted = <String>{
        for (final DefaultedEntry e in result.report.defaulted) e.token,
      };
      expect(defaulted, <String>{
        'radius',
        'spacing',
        'tracking.normal',
        'shadow.light',
        'shadow.dark',
      });
    });
  });
}
