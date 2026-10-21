// Font-source decision tests: the sample families resolve to Google
// Fonts, an unknown family falls back to the local path with a clear
// report reason, and the snippet builders stay well-formed.

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('google fonts catalogue', () {
    test('the sample families all resolve to google fonts', () {
      for (final String family in <String>[
        'Orbitron',
        'Rajdhani',
        'Fira Code',
      ]) {
        final FontResolution resolution = resolveFontFamily(family);
        expect(resolution.source, FontSource.google, reason: family);
        expect(resolution.reason, contains('Google Fonts'));
      }
    });

    test('a made-up family falls back to the local path, loudly', () {
      final FontResolution resolution = resolveFontFamily('MadeUpFamilyXyz');
      expect(resolution.source, FontSource.local);
      expect(resolution.reason, contains('dashcn font add'));
      expect(resolution.reason, contains('MadeUpFamilyXyz'));
    });

    test('the version pin is at least two weeks old', () {
      // Pinned 2026-10-21 (google_fonts 9.0.0, published 2026-09-28);
      // the CLI rewrites this pin when it applies a preset.
      expect(kGoogleFontsVersionPin, '^9.0.0');
    });
  });

  group('family extraction', () {
    test('first non-generic family wins, quotes stripped', () {
      expect(firstFontFamily("'Orbitron', sans-serif"), 'Orbitron');
      expect(firstFontFamily('"Fira Code", monospace'), 'Fira Code');
      expect(firstFontFamily('Rajdhani, sans-serif'), 'Rajdhani');
      expect(firstFontFamily('sans-serif'), isNull);
      expect(firstFontFamily(''), isNull);
      expect(firstFontFamily(null), isNull);
    });
  });

  group('snippets', () {
    test('google pubspec line names the pinned package', () {
      expect(googleFontsPubspecLine(), '  google_fonts: ^9.0.0');
    });

    test('generated code uses getFont so any catalogue family works', () {
      expect(
        googleFontsGetFontExpression('Orbitron'),
        "GoogleFonts.getFont('Orbitron')",
      );
    });

    test('local block declares the family and its asset', () {
      expect(
        localFontPubspecBlock(
          family: 'MadeUpFamilyXyz',
          asset: 'assets/fonts/MadeUpFamilyXyz-Regular.ttf',
        ),
        contains('family: MadeUpFamilyXyz'),
      );
    });
  });
}
