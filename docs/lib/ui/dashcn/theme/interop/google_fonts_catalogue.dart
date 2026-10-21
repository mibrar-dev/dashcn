// Google Fonts catalogue snapshot + font-source decision (pure Dart).
//
// When an imported theme names a font family, the CLI looks it up here
// first: found → Google Fonts (adds the `google_fonts` package to the
// user's pubspec, writes `GoogleFonts.getFont('…')` usage); missing →
// the local-font path (`dashcn font add`), reported, never a silent
// fallback.
//
// The set below is a *bundled fallback snapshot*, not the live catalogue:
// the CLI fetches `kGoogleFontsMetadataUrl` (no API key needed) and caches
// it at `kGoogleFontsCacheFile`, falling back to this set offline. The kit
// itself never depends on `google_fonts` and stays widgets-only — only the
// *generated user file* references `GoogleFonts`.

/// google_fonts version the CLI pins into a user's pubspec.
///
/// 9.0.0 published 2026-09-28, more than two weeks before this batch
/// (2026-10-21); re-pin to another ≥2-week-old release when wiring the CLI
/// if a newer major has landed since.
const String kGoogleFontsVersionPin = '^9.0.0';

/// Public Google Fonts metadata list: no API key needed, fetched by the CLI.
const String kGoogleFontsMetadataUrl =
    'https://fonts.google.com/metadata/fonts';

/// CLI cache file (project-relative) for the fetched family list.
const String kGoogleFontsCacheFile = '.dashcn/google-fonts.json';

/// CSS generic families: never a real named family.
const Set<String> kGenericFontFamilies = <String>{
  'sans-serif',
  'serif',
  'monospace',
  'ui-sans-serif',
  'ui-monospace',
  'ui-serif',
  'system-ui',
  'cursive',
  'fantasy',
};

/// Bundled catalogue snapshot (fallback when the CLI cache is unreachable).
///
/// Verified 2026-10-21 against the public metadata list; includes the
/// theme-import sample families (Orbitron, Rajdhani, Fira Code) and every
/// family the docs Studio bundles. The CLI refreshes from
/// [kGoogleFontsMetadataUrl]; this set only decides the offline answer.
const Set<String> kGoogleFontsFamilies = <String>{
  'Orbitron',
  'Rajdhani',
  'Fira Code',
  'Playfair Display',
  'Lora',
  'Space Grotesk',
  'DM Sans',
  'Manrope',
  'Inter',
  'Outfit',
  'Plus Jakarta Sans',
  'IBM Plex Sans',
  'JetBrains Mono',
  'Roboto',
  'Open Sans',
  'Montserrat',
  'Poppins',
  'Raleway',
  'Nunito',
  'Ubuntu',
  'Rubik',
  'Work Sans',
  'Fira Sans',
  'Source Sans 3',
  'Noto Sans',
  'Lato',
  'Oswald',
  'Bebas Neue',
  'Anton',
  'Archivo',
  'Barlow',
  'Cabin',
  'Heebo',
  'Karla',
  'Libre Franklin',
  'Public Sans',
  'Hanken Grotesk',
  'Sora',
  'Epilogue',
  'Lexend',
  'Jost',
  'Quicksand',
  'Comfortaa',
  'Exo 2',
  'Chakra Petch',
  'Audiowede',
  'Michroma',
  'Syncopate',
  'Zen Dots',
  'Major Mono Display',
  'Share Tech Mono',
  'IBM Plex Mono',
  'Space Mono',
  'Source Code Pro',
  'Inconsolata',
  'Cascadia Code',
  'Geist',
  'Geist Mono',
  'Merriweather',
  'PT Serif',
  'Playfair',
  'Crimson Pro',
  'Libre Baskerville',
  'Bitter',
  'Zilla Slab',
  'Arvo',
  'Rokkitt',
  'Spectral',
  'Fraunces',
  'DM Serif Display',
  'Newsreader',
  'Instrument Serif',
  'Bodoni Moda',
  'Cormorant Garamond',
  'EB Garamond',
  'Dancing Script',
  'Pacifico',
  'Caveat',
  'Shadows Into Light',
  'Indie Flower',
  'Kalam',
  'Permanent Marker',
  'Bangers',
  'Lobster',
  'Satisfy',
  'Great Vibes',
  'Allura',
  'Sacramento',
  'Tangerine',
  'Yellowtail',
  'Abril Fatface',
  'Cinzel',
  'Marcellus',
  'Cormorant',
  'Tenor Sans',
  'Julius Sans One',
  'Poiret One',
  'Righteous',
  'Fredoka',
  'Baloo 2',
  'Chewy',
  'Titan One',
  'Luckiest Guy',
  'Bungee',
  'Monoton',
  'Press Start 2P',
  'VT323',
  'Silkscreen',
  'DotGothic16',
  'IBM Plex Serif',
  'Source Serif 4',
  'Noto Serif',
  'Literata',
  'STIX Two Text',
  'Suwannaphum',
  'Kantumruy Pro',
  'Koh Santepheap',
  'Battambang',
  'Angkor',
  'Inter Tight',
  'Archivo Narrow',
  'Fjalla One',
  'Six Caps',
  'Wire One',
  'Monsieur La Doulaise',
};

/// Where a font family resolves to.
enum FontSource {
  /// On Google Fonts: the CLI adds the package and uses `GoogleFonts`.
  google,

  /// Not on Google Fonts: copy the file in with `dashcn font add`.
  local,
}

/// One family's source decision, with the reason for the report line.
final class FontResolution {
  /// Creates the decision.
  const FontResolution({
    required this.family,
    required this.source,
    required this.reason,
  });

  /// The family as named by the theme.
  final String family;

  /// Google Fonts, or the local-font path.
  final FontSource source;

  /// Why (catalogue hit, or catalogue miss → local path).
  final String reason;
}

/// The first non-generic family of a CSS font spec (`'Orbitron', sans-serif`
/// → `Orbitron`), quote-stripped; null when the spec names no real family.
String? firstFontFamily(String? spec) {
  if (spec == null || spec.trim().isEmpty) {
    return null;
  }
  for (final String part in spec.split(',')) {
    final String family = part
        .trim()
        .replaceAll("'", '')
        .replaceAll('"', '')
        .trim();
    if (family.isNotEmpty &&
        !kGenericFontFamilies.contains(family.toLowerCase())) {
      return family;
    }
  }
  return null;
}

/// Decides [family]'s source against the bundled catalogue snapshot.
///
/// Found → [FontSource.google] (default, and why: zero asset work, always
/// in sync with the design); missing → [FontSource.local] with the reason
/// the CLI prints. Never throws, never silently substitutes another family.
FontResolution resolveFontFamily(String family) {
  final String name = family.trim();
  if (kGoogleFontsFamilies.contains(name)) {
    return FontResolution(
      family: name,
      source: FontSource.google,
      reason:
          'on Google Fonts; CLI adds $kGoogleFontsPackageName '
          '$kGoogleFontsVersionPin',
    );
  }
  return FontResolution(
    family: name,
    source: FontSource.local,
    reason:
        'not on Google Fonts; copy the file in with '
        '`dashcn font add $name <file>`',
  );
}

/// The pub.dev package the CLI adds for Google families.
const String kGoogleFontsPackageName = 'google_fonts';

/// The `dependencies:` line the CLI appends to the user's pubspec.
String googleFontsPubspecLine() =>
    '  $kGoogleFontsPackageName: $kGoogleFontsVersionPin';

/// The generated-code expression for [family] (`getFont` stays valid for
/// every catalogue family, including future ones with no helper method).
String googleFontsGetFontExpression(String family) =>
    "GoogleFonts.getFont('$family')";

/// The `flutter: fonts:` block the CLI appends for a local family.
String localFontPubspecBlock({required String family, required String asset}) =>
    '  - family: $family\n'
    '    fonts:\n'
    '      - asset: $asset';
