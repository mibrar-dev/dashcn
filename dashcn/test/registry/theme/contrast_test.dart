import 'dart:convert';
import 'dart:io';

import 'package:dashcn/src/primitives/color_math.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/contrast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// WCAG helpers and the `onMuted` derivation: untouched-when-passing plus a
/// 4.5:1 guarantee on `muted` for every preset, light and dark.
void main() {
  test('textContrastRatio matches the known values', () {
    expect(
      textContrastRatio(const Color(0xFF000000), const Color(0xFFFFFFFF)),
      closeTo(21, 0.01),
    );
    expect(
      textContrastRatio(const Color(0xFF737373), const Color(0xFF737373)),
      closeTo(1, 0.001),
    );
    // Neutral light `mutedForeground` on `muted`: the 4.35:1 failure.
    expect(
      textContrastRatio(const Color(0xFF737373), const Color(0xFFF5F5F5)),
      allOf(greaterThan(4.3), lessThan(4.5)),
    );
    // Same pair through the primitives helper, for parity.
    expect(
      contrastRatio(const Color(0xFF737373), const Color(0xFFF5F5F5)),
      closeTo(
        textContrastRatio(const Color(0xFF737373), const Color(0xFFF5F5F5)),
        0.001,
      ),
    );
  });

  test('ensureTextContrast returns passing text untouched', () {
    const text = Color(0xFF0A0A0A);
    const surface = Color(0xFFFFFFFF);
    expect(
      ensureTextContrast(
        text,
        surface: surface,
        towards: const Color(0xFF171717),
      ),
      same(text),
    );
  });

  test('neutral light onMuted reaches 4.5 on muted', () {
    const colors = ThemeColors.lightFallback;
    expect(
      textContrastRatio(colors.mutedForeground, colors.muted),
      lessThan(4.5),
    );
    final Color fixed = colors.onMuted;
    expect(textContrastRatio(fixed, colors.muted), greaterThanOrEqualTo(4.5));
    // Darker than the raw token, same hue family (grey stays grey).
    expect(
      fixed.computeLuminance(),
      lessThan(colors.mutedForeground.computeLuminance()),
    );
  });

  test('dark fallback onMuted stays pixel-identical', () {
    const colors = ThemeColors.darkFallback;
    expect(colors.onMuted, colors.mutedForeground);
  });

  test('onMuted reaches 4.5 on muted for every preset, light and dark', () {
    final Directory dir = Directory('lib/src/themes');
    final List<File> presets = dir
        .listSync()
        .whereType<File>()
        .where(
          (file) =>
              file.path.endsWith('.json') &&
              !file.path.endsWith('index.json') &&
              !file.path.endsWith('themes.schema.json'),
        )
        .toList();
    // The brief forbids editing these; the sweep pins their count.
    expect(presets.length, 43);
    final List<String> failures = <String>[];
    for (final File file in presets) {
      final Map<String, Object?> decoded =
          jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
      for (final String mode in <String>['light', 'dark']) {
        final Map<String, Object?>? tokens =
            decoded[mode] as Map<String, Object?>?;
        if (tokens == null) {
          continue;
        }
        Color? hex(String key) {
          final Object? raw = tokens[key];
          if (raw is! String) {
            return null;
          }
          return colorFromHex(raw);
        }

        final Color? muted = hex('muted');
        final Color? mutedForeground = hex('mutedForeground');
        final Color? foreground = hex('foreground');
        if (muted == null || mutedForeground == null || foreground == null) {
          continue;
        }
        final ThemeColors colors = ThemeColors.lightFallback.copyWith(
          brightness: mode == 'dark' ? Brightness.dark : Brightness.light,
          muted: muted,
          mutedForeground: mutedForeground,
          foreground: foreground,
        );
        final double ratio = textContrastRatio(colors.onMuted, colors.muted);
        if (ratio < 4.5) {
          failures.add('${file.uri.pathSegments.last} $mode $ratio');
        }
      }
    }
    expect(failures, isEmpty, reason: failures.join('\n'));
  });
}
