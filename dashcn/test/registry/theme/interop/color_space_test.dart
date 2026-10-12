// Colour-space unit tests: parsing of every notation, conversion against
// published Oklch primaries, CIEDE2000 against the Sharma reference pair,
// and gamut mapping behaviour.

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hex', () {
    test('six digits default to opaque', () {
      expect(parseWebColor('#1A2B3C'), 0xFF1A2B3C);
      expect(webHexOf(0xFF1A2B3C), '#1A2B3C');
    });

    test('short forms expand', () {
      expect(parseWebColor('#f00'), 0xFFFF0000);
      expect(parseWebColor('#f00a'), 0xAAFF0000);
      expect(webHexOf(0xAAFF0000), '#FF0000AA');
    });

    test('eight digits keep alpha', () {
      expect(parseWebColor('#FFFFFF1A'), 0x1AFFFFFF);
      expect(webHexOf(0x1AFFFFFF), '#FFFFFF1A');
    });

    test('rejects malformed hex', () {
      expect(() => parseWebColor('#FFF00'), throwsA(isA<WebColorException>()));
      expect(() => parseWebColor('#GGGGGG'), throwsA(isA<WebColorException>()));
      expect(
        () => parseWebColor('0xFF0000'),
        throwsA(isA<WebColorException>()),
      );
    });
  });

  group('functional notations', () {
    test('oklch with all alpha styles', () {
      expect(parseWebColor('oklch(0.6279 0.2576 29.23)'), 0xFFFF0000);
      expect(parseWebColor('oklch(62.79% 0.2576 29.23deg / 50%)'), 0x80FF0000);
      expect(parseWebColor('oklch(0.6279, 0.2576, 29.23, 0.5)'), 0x80FF0000);
    });

    test('oklab white and black', () {
      expect(parseWebColor('oklab(1 0 0)'), 0xFFFFFFFF);
      expect(parseWebColor('oklab(0 0 0)'), 0xFF000000);
    });

    test('hsl comma, space and slash forms agree', () {
      const expected = 0xFF0F172A;
      expect(parseWebColor('hsl(222.2, 47.4%, 11.2%)'), expected);
      expect(parseWebColor('hsl(222.2 47.4% 11.2%)'), expected);
      expect(parseWebColor('222.2 47.4% 11.2%'), expected);
      expect(parseWebColor('hsl(222.2 47.4% 11.2% / 100%)'), expected);
    });

    test('rgb comma, space and slash forms agree', () {
      expect(parseWebColor('rgb(255, 0, 0)'), 0xFFFF0000);
      expect(parseWebColor('rgb(255 0 0)'), 0xFFFF0000);
      expect(parseWebColor('rgb(255 0 0 / 50%)'), 0x80FF0000);
      expect(parseWebColor('rgba(255, 0, 0, 0.5)'), 0x80FF0000);
      expect(parseWebColor('rgb(100% 0% 0%)'), 0xFFFF0000);
    });

    test('keywords', () {
      expect(parseWebColor('white'), 0xFFFFFFFF);
      expect(parseWebColor('transparent'), 0x00000000);
      expect(parseWebColor('red'), 0xFFFF0000);
    });

    test('references throw instead of misparsing', () {
      expect(
        () => parseWebColor('hsl(var(--primary))'),
        throwsA(isA<WebColorException>()),
      );
      expect(tryParseWebColor('color-mix(in oklch, red, blue)'), isNull);
      expect(tryParseWebColor('not a colour'), isNull);
      expect(tryParseWebColor(''), isNull);
    });
  });

  group('oklch conversion vs published primaries', () {
    void expectOklch(String hex, double l, double c, double h) {
      final Oklch oklch = oklchFromArgb(parseWebColor(hex));
      expect(oklch.lightness, closeTo(l, 0.002), reason: hex);
      expect(oklch.chroma, closeTo(c, 0.002), reason: hex);
      expect(oklch.hue, closeTo(h, 0.1), reason: hex);
    }

    test('primaries match published values', () {
      // Reference values as published by the Oklch reference (oklch.com).
      expectOklch('#FFFFFF', 1, 0, 0);
      expectOklch('#000000', 0, 0, 0);
      expectOklch('#FF0000', 0.62796, 0.25768, 29.234);
      expectOklch('#00FF00', 0.86644, 0.29483, 142.495);
      expectOklch('#0000FF', 0.45201, 0.31321, 264.052);
    });

    test('achromatic colours snap hue to zero', () {
      expect(oklchFromArgb(0xFF808080).hue, 0);
      expect(oklchOf(0xFFFFFFFF), 'oklch(1 0 0)');
      expect(oklchOf(0xFF000000), 'oklch(0 0 0)');
    });

    test('in-gamut colours survive oklch intact', () {
      for (final int argb in <int>[
        0xFF0F172A,
        0xFFF54900,
        0x80FFFFFF,
        0x1AFFFFFF,
      ]) {
        expect(argbFromOklch(oklchFromArgb(argb)), argb);
      }
    });
  });

  group('gamut mapping', () {
    test('out-of-gamut chroma is reduced, hue and lightness kept', () {
      const Oklch wide = Oklch(0.5, 0.4, 20);
      final Oklch mapped = oklchFromArgb(argbFromOklch(wide));
      expect(mapped.chroma, lessThan(wide.chroma));
      expect(mapped.lightness, closeTo(0.5, 0.02));
      expect(mapped.hue, closeTo(20, 3));
    });

    test('mapping can be disabled to detect overflow', () {
      const Oklch wide = Oklch(0.5, 0.4, 20);
      final int raw = argbFromOklch(wide, gamutMap: false);
      final int mapped = argbFromOklch(wide);
      expect(raw, isNot(mapped));
    });
  });

  group('deltaE2000', () {
    test('matches the Sharma reference pair', () {
      // Sharma et al. Table I, pair 1: ΔE00 = 2.0425.
      const CieLab a = CieLab(50.0, 2.6772, -79.7751);
      const CieLab b = CieLab(50.0, 0.0, -82.7485);
      expect(deltaE2000Lab(a, b), closeTo(2.0425, 0.0005));
    });

    test('identical colours are zero and distance is symmetric', () {
      expect(deltaE2000(0xFF123456, 0xFF123456), 0);
      final double forward = deltaE2000(0xFFFF0000, 0xFF0000FF);
      expect(deltaE2000(0xFF0000FF, 0xFFFF0000), closeTo(forward, 1e-9));
      expect(forward, greaterThan(10));
    });
  });
}
