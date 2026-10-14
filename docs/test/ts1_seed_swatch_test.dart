// P7-TS1 bug 1: the Base/Theme/Chart colour pickers must let every swatch
// select itself. Black/grey used to derive hue-0 "Red" ramps, so a neutral
// seed looked selected and resolved to red.
//
// These tests pin the derivation: an achromatic seed yields a neutral ramp,
// a chromatic seed keeps its hue, and the whole family stays valid.

import 'dart:convert';

import 'package:docs/theme/theme_document.dart';
import 'package:docs/theme/theme_palette.dart';
import 'package:docs/widgets/rail_pickers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ThemeDocument base = ThemeDocument.fromPreset('neutral');

  Color accentPrimary(Color seed) =>
      docsColorOf(applyAccentColor(base, seed).light['primary']!);

  Color chartOf(Color seed, int index) => docsColorOf(
    applyChartColors(base, seed).light[kDocsChartTokenKeys[index]]!,
  );

  bool isNeutral(Color color) => HSLColor.fromColor(color).saturation < 0.1;

  group('seed swatch derivation', () {
    test('every achromatic swatch selects itself as neutral, never red', () {
      for (final Color seed in const <Color>[
        Color(0xFF171717), // black
        Color(0xFF737373), // grey
        Color(0xFFFFFFFF), // white
      ]) {
        expect(
          isNeutral(accentPrimary(seed)),
          isTrue,
          reason:
              'accent of 0x${seed.toARGB32().toRadixString(16)} '
              'must be neutral',
        );
        expect(
          docsColorName(accentPrimary(seed)),
          'Neutral',
          reason: 'a neutral seed must read as Neutral, not Red',
        );
      }
    });

    test('black stays darker than grey stays darker than white', () {
      final double black = HSLColor.fromColor(
        accentPrimary(const Color(0xFF171717)),
      ).lightness;
      final double grey = HSLColor.fromColor(
        accentPrimary(const Color(0xFF737373)),
      ).lightness;
      final double white = HSLColor.fromColor(
        accentPrimary(const Color(0xFFFFFFFF)),
      ).lightness;
      expect(black, lessThan(grey));
      expect(grey, lessThanOrEqualTo(white));
    });

    test('a chromatic seed keeps its hue', () {
      final Color blue = accentPrimary(const Color(0xFF2563EB));
      final HSLColor hsl = HSLColor.fromColor(blue);
      expect(hsl.saturation, greaterThan(0.1));
      expect(hsl.hue, greaterThan(180));
      expect(hsl.hue, lessThan(260));
      expect(docsColorName(blue), 'Blue');
    });

    test('a neutral seed yields a neutral chart ramp', () {
      for (int i = 0; i < kDocsChartTokenKeys.length; i += 1) {
        expect(
          isNeutral(chartOf(const Color(0xFF171717), i)),
          isTrue,
          reason: 'chart ${i + 1} of a neutral seed must stay neutral',
        );
      }
    });

    test('a neutral chart ramp is still distinguishable by lightness', () {
      final List<double> lightness = <double>[
        for (int i = 0; i < kDocsChartTokenKeys.length; i++)
          HSLColor.fromColor(chartOf(const Color(0xFF737373), i)).lightness,
      ];
      for (int i = 1; i < lightness.length; i += 1) {
        expect(lightness[i], greaterThan(lightness[i - 1]));
      }
    });

    test('a chromatic chart seed keeps spaced hues', () {
      const Color seed = Color(0xFF2563EB);
      final List<double> hues = <double>[
        for (int i = 0; i < kDocsChartTokenKeys.length; i++)
          HSLColor.fromColor(chartOf(seed, i)).hue,
      ];
      expect((hues[1] - hues[0]) % 360, closeTo(60, 1));
      expect((hues[2] - hues[1]) % 360, closeTo(60, 1));
      expect((hues[3] - hues[2]) % 360, closeTo(60, 1));
    });

    test('base colour of a neutral seed writes a neutral document', () {
      final ThemeDocument next = applyBaseColor(base, const Color(0xFF171717));
      final HSLColor background = HSLColor.fromColor(
        docsColorOf(next.light['background']!),
      );
      expect(background.saturation, lessThan(0.1));
    });

    test('derived documents stay parseable for every offered seed', () {
      for (final Color seed in kDocsSeedSwatches) {
        for (final ThemeDocument next in <ThemeDocument>[
          applyAccentColor(base, seed),
          applyBaseColor(base, seed),
          applyChartColors(base, seed),
        ]) {
          final Map<String, Object?> decoded =
              jsonDecode(next.json) as Map<String, Object?>;
          expect(
            () => ThemeDocument.fromJson(<String, Object?>{
              for (final MapEntry<Object?, Object?> entry in decoded.entries)
                entry.key.toString(): entry.value,
            }),
            returnsNormally,
            reason:
                'derived document for 0x${seed.toARGB32().toRadixString(16)} '
                'must stay schema-valid',
          );
        }
      }
    });

    test('the accent family keeps dark mode readable for a neutral seed', () {
      final ThemeDocument next = applyAccentColor(
        base,
        const Color(0xFF737373),
      );
      final Color dark = docsColorOf(next.dark['primary']!);
      expect(isNeutral(dark), isTrue);
      expect(dark.computeLuminance(), greaterThan(0.05));
    });
  });
}
