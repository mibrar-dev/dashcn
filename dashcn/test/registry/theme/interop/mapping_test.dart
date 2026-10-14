// Mapping-table tests: every kit token has exactly one row (or a documented
// alias), the reverse map round-trips, and missing-token reporting agrees
// with `WebTheme.completed`.

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:dashcn/src/theme/interop/internal/css_mapping.dart';
import 'package:dashcn/src/theme/interop/internal/theme_diagnostics.dart';
import 'package:dashcn/src/theme/interop/internal/token_inventory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every kit colour token is covered exactly once', () {
    expect(kCssColorToKit.length, 33); // 32 tokens + sidebar-background alias
    expect(kCssColorToKit.values.toSet(), kKitColorTokens.toSet());
    for (final String token in kKitColorTokens) {
      final String? variable = kitTokenToCssVar(token);
      expect(variable, isNotNull, reason: token);
      expect(variable, startsWith('--'));
      expect(cssVarToKitToken(variable!), token);
      expect(cssVarToKitToken(variable.substring(2)), token);
    }
    expect(cssVarToKitToken('--sidebar-background'), 'sidebar');
    expect(kitTokenToCssVar('sidebar'), '--sidebar');
  });

  test('scalar rows cover radius, fonts, spacing, tracking and atoms', () {
    expect(kCssFontToSlot.values.toSet(), <String>{'sans', 'serif', 'mono'});
    expect(kCssTrackingToStep.values.toSet(), <String>{
      'normal',
      'tight',
      'wide',
    });
    expect(kCssShadowToAtom.values.toSet(), <String>{
      'color',
      'opacity',
      'blur',
      'spread',
      'offsetX',
      'offsetY',
    });
    expect(cssVarToKitToken('--radius'), isNull); // scalar, not a colour
  });

  test('known-derived variables explain themselves', () {
    expect(ignoredReason('--radius-sm'), contains('recomputed'));
    expect(ignoredReason('--shadow-xl'), contains('recomputed'));
    expect(ignoredReason('--color-red-500'), contains('palette ramp'));
    expect(ignoredReason('--animate-fade'), 'no kit token counterpart');
    expect(ignoredReason('--background'), isNull);
    expect(ignoredReason('--font-sans'), isNull);
    expect(ignoredReason('--shadow-opacity'), isNull);
    expect(ignoredReason('--nope'), 'unknown variable');
  });

  test('missingTokens agrees with completed()', () {
    const WebTheme empty = WebTheme();
    final List<String> missing = missingTokens(empty);
    // 64 colours + radius/spacing/tracking.normal + 3 fonts + tight/wide +
    // 12 shadow atoms; optional tokens carry an ` (optional)` suffix.
    expect(missing.length, 64 + 3 + 3 + 2 + 12);
    expect(missing, contains('light.primary'));
    expect(missing, contains('dark.ring'));
    expect(missing, contains('radius'));
    expect(missing, contains('tracking.normal'));
    expect(missing, contains('shadow.dark.blur'));
    expect(missing, contains('fonts.sans (optional)'));
    expect(missing, contains('tracking.tight (optional)'));

    final ImportReport report = ImportReport();
    final WebTheme filled = empty.completed(report);
    // Optionals stay absent (valid); everything required is filled.
    expect(missingTokens(filled), <String>[
      'fonts.sans (optional)',
      'fonts.serif (optional)',
      'fonts.mono (optional)',
      'tracking.tight (optional)',
      'tracking.wide (optional)',
    ]);
    // completed() groups the 12 atoms into two mode entries.
    expect(report.defaulted.length, 64 + 3 + 2);
  });
}
