// Neutral web-theme model for import/export (pure Dart, no Flutter import).
//
// [WebTheme] is the boundary type every parser produces and every writer
// consumes: per-mode colour maps keyed by kit token names (`background`,
// `primaryForeground`, `chart1`, `sidebarRing`, …), plus the non-colour
// tokens. Colours are 32-bit ARGB ints; lengths keep their web units until
// the writers convert (rem for radius/spacing, em for tracking, px for
// shadow atoms — matching the preset schema).

/// Base shadow atoms of one mode (the eight derived sizes are always
/// recomputed at build time, never stored).
final class WebShadowAtoms {
  /// Creates the atoms.
  const WebShadowAtoms({
    required this.color,
    required this.opacity,
    required this.blur,
    required this.spread,
    required this.offsetX,
    required this.offsetY,
  });

  /// Default atoms (the neutral preset values).
  static const WebShadowAtoms fallback = WebShadowAtoms(
    color: 0xFF000000,
    opacity: 0.1,
    blur: 3,
    spread: 0,
    offsetX: 0,
    offsetY: 1,
  );

  /// Shadow colour (ARGB), base alpha 0..1, blur/spread/offsets in px.
  final int color;
  final double opacity;
  final double blur;
  final double spread;
  final double offsetX;
  final double offsetY;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WebShadowAtoms &&
          other.color == color &&
          other.opacity == opacity &&
          other.blur == blur &&
          other.spread == spread &&
          other.offsetX == offsetX &&
          other.offsetY == offsetY;

  @override
  int get hashCode =>
      Object.hash(color, opacity, blur, spread, offsetX, offsetY);
}

/// One imported entry: a web variable that became a kit token.
final class MappedEntry {
  /// Creates the entry.
  const MappedEntry(this.variable, this.token, [this.detail = '']);

  /// Web variable, kit token, and extra detail (`resolved …`, …).
  final String variable;
  final String token;
  final String detail;

  /// JSON form.
  Map<String, Object?> toJson() => <String, Object?>{
    'variable': variable,
    'token': token,
    if (detail.isNotEmpty) 'detail': detail,
  };
}

/// One kit token the source did not name: filled from the fallback preset.
final class DefaultedEntry {
  /// Creates the entry.
  const DefaultedEntry(this.token, this.reason);

  /// Kit token and why the fallback was used.
  final String token;
  final String reason;

  /// JSON form.
  Map<String, Object?> toJson() => <String, Object?>{
    'token': token,
    'reason': reason,
  };
}

/// One web variable that was skipped, with the reason. Never silent.
final class IgnoredEntry {
  /// Creates the entry.
  const IgnoredEntry(this.variable, this.reason);

  /// Web variable and why it was skipped.
  final String variable;
  final String reason;

  /// JSON form.
  Map<String, Object?> toJson() => <String, Object?>{
    'variable': variable,
    'reason': reason,
  };
}

/// What an import mapped, defaulted and ignored — never silent.
class ImportReport {
  /// Creates an empty report; parsers append as they go.
  ImportReport();

  /// Variables that became kit tokens.
  final List<MappedEntry> mapped = <MappedEntry>[];

  /// Kit tokens filled from fallbacks.
  final List<DefaultedEntry> defaulted = <DefaultedEntry>[];

  /// Variables that were skipped, each with a reason.
  final List<IgnoredEntry> ignored = <IgnoredEntry>[];

  /// Whether every kit token came from the source (no fallbacks).
  bool get isClean => defaulted.isEmpty && ignored.isEmpty;

  /// JSON form.
  Map<String, Object?> toJson() => <String, Object?>{
    'mapped': <Object?>[for (final MappedEntry e in mapped) e.toJson()],
    'defaulted': <Object?>[
      for (final DefaultedEntry e in defaulted) e.toJson(),
    ],
    'ignored': <Object?>[for (final IgnoredEntry e in ignored) e.toJson()],
  };
}

/// Neutral web theme: light/dark colour maps plus non-colour tokens.
///
/// Colour maps are keyed by kit token name (see `mapping.dart`); a missing
/// key means "the source did not name it" until [completed] fills it.
final class WebTheme {
  /// Creates a theme from its parts.
  const WebTheme({
    this.light = const <String, int>{},
    this.dark = const <String, int>{},
    this.radius,
    this.fonts = const <String, String>{},
    this.spacing,
    this.tracking = const <String, double>{},
    this.lightShadow,
    this.darkShadow,
  });

  /// Colours by kit token; radius (rem); fonts; spacing (rem); tracking
  /// (em); base shadow atoms per mode. Null/absent means "not named".
  final Map<String, int> light;
  final Map<String, int> dark;
  final double? radius;
  final Map<String, String> fonts;
  final double? spacing;
  final Map<String, double> tracking;
  final WebShadowAtoms? lightShadow;
  final WebShadowAtoms? darkShadow;

  /// Copy with the given fields replaced.
  WebTheme copyWith({
    Map<String, int>? light,
    Map<String, int>? dark,
    double? Function()? radius,
    Map<String, String>? fonts,
    double? Function()? spacing,
    Map<String, double>? tracking,
    WebShadowAtoms? Function()? lightShadow,
    WebShadowAtoms? Function()? darkShadow,
  }) {
    return WebTheme(
      light: light ?? this.light,
      dark: dark ?? this.dark,
      radius: radius == null ? this.radius : radius(),
      fonts: fonts ?? this.fonts,
      spacing: spacing == null ? this.spacing : spacing(),
      tracking: tracking ?? this.tracking,
      lightShadow: lightShadow == null ? this.lightShadow : lightShadow(),
      darkShadow: darkShadow == null ? this.darkShadow : darkShadow(),
    );
  }

  /// Returns this theme with every missing token filled from [kFallbackLight]
  /// / [kFallbackDark] and the scalar fallbacks, recording each fill in
  /// [report] when given. Writers call this so output is always complete.
  WebTheme completed([ImportReport? report]) {
    final Map<String, int> nextLight = Map<String, int>.of(light);
    final Map<String, int> nextDark = Map<String, int>.of(dark);
    for (final String token in kKitColorTokens) {
      if (!nextLight.containsKey(token)) {
        nextLight[token] = kFallbackLight[token]!;
        report?.defaulted.add(
          DefaultedEntry(token, 'missing in light mode; fallback used'),
        );
      }
      if (!nextDark.containsKey(token)) {
        nextDark[token] = kFallbackDark[token]!;
        report?.defaulted.add(
          DefaultedEntry(token, 'missing in dark mode; fallback used'),
        );
      }
    }
    WebShadowAtoms atoms(WebShadowAtoms? value, String mode) {
      if (value != null) {
        return value;
      }
      report?.defaulted.add(
        DefaultedEntry('shadow.$mode', 'missing; fallback atoms used'),
      );
      return WebShadowAtoms.fallback;
    }

    if (radius == null) {
      report?.defaulted.add(
        const DefaultedEntry('radius', 'missing; 0.625 used'),
      );
    }
    if (spacing == null) {
      report?.defaulted.add(
        const DefaultedEntry('spacing', 'missing; 0.25 used'),
      );
    }
    final Map<String, double> nextTracking = Map<String, double>.of(tracking);
    if (!nextTracking.containsKey('normal')) {
      nextTracking['normal'] = 0;
      report?.defaulted.add(
        const DefaultedEntry('tracking.normal', 'missing; 0 used'),
      );
    }
    return WebTheme(
      light: Map<String, int>.unmodifiable(nextLight),
      dark: Map<String, int>.unmodifiable(nextDark),
      radius: radius ?? 0.625,
      fonts: fonts,
      spacing: spacing ?? 0.25,
      tracking: Map<String, double>.unmodifiable(nextTracking),
      lightShadow: atoms(lightShadow, 'light'),
      darkShadow: atoms(darkShadow, 'dark'),
    );
  }
}

// ---------------------------------------------------------------------------
// Kit token inventory and fallback values
// ---------------------------------------------------------------------------

/// The 32 kit colour tokens in constructor order (mirrors the generator's
/// `colorTokenKeys` and the preset schema; asserted equal by a test).
const List<String> kKitColorTokens = <String>[
  'background',
  'foreground',
  'card',
  'cardForeground',
  'popover',
  'popoverForeground',
  'primary',
  'primaryForeground',
  'secondary',
  'secondaryForeground',
  'muted',
  'mutedForeground',
  'accent',
  'accentForeground',
  'destructive',
  'destructiveForeground',
  'border',
  'input',
  'ring',
  'chart1',
  'chart2',
  'chart3',
  'chart4',
  'chart5',
  'sidebar',
  'sidebarForeground',
  'sidebarPrimary',
  'sidebarPrimaryForeground',
  'sidebarAccent',
  'sidebarAccentForeground',
  'sidebarBorder',
  'sidebarRing',
];

/// Fallback colours, transcribed from the neutral preset (`neutral.json`):
/// anything an import does not name falls back to these, recorded in the
/// report's `defaulted` list.
const Map<String, String> kFallbackLightHex = <String, String>{
  'background': '#FFFFFF',
  'foreground': '#0A0A0A',
  'card': '#FFFFFF',
  'cardForeground': '#0A0A0A',
  'popover': '#FFFFFF',
  'popoverForeground': '#0A0A0A',
  'primary': '#171717',
  'primaryForeground': '#FAFAFA',
  'secondary': '#F5F5F5',
  'secondaryForeground': '#171717',
  'muted': '#F5F5F5',
  'mutedForeground': '#737373',
  'accent': '#F5F5F5',
  'accentForeground': '#171717',
  'destructive': '#E7000B',
  'destructiveForeground': '#FCF3F3',
  'border': '#E5E5E5',
  'input': '#E5E5E5',
  'ring': '#A1A1A1',
  'chart1': '#F54900',
  'chart2': '#009689',
  'chart3': '#104E64',
  'chart4': '#FFB900',
  'chart5': '#FE9A00',
  'sidebar': '#FAFAFA',
  'sidebarForeground': '#0A0A0A',
  'sidebarPrimary': '#171717',
  'sidebarPrimaryForeground': '#FAFAFA',
  'sidebarAccent': '#F5F5F5',
  'sidebarAccentForeground': '#171717',
  'sidebarBorder': '#E5E5E5',
  'sidebarRing': '#A1A1A1',
};

/// Dark-mode fallbacks, transcribed from the neutral preset.
const Map<String, String> kFallbackDarkHex = <String, String>{
  'background': '#0A0A0A',
  'foreground': '#FAFAFA',
  'card': '#171717',
  'cardForeground': '#FAFAFA',
  'popover': '#171717',
  'popoverForeground': '#FAFAFA',
  'primary': '#E5E5E5',
  'primaryForeground': '#171717',
  'secondary': '#262626',
  'secondaryForeground': '#FAFAFA',
  'muted': '#262626',
  'mutedForeground': '#A1A1A1',
  'accent': '#262626',
  'accentForeground': '#FAFAFA',
  'destructive': '#FF6467',
  'destructiveForeground': '#DF2225',
  'border': '#FFFFFF1A',
  'input': '#FFFFFF26',
  'ring': '#737373',
  'chart1': '#1447E6',
  'chart2': '#00BC7D',
  'chart3': '#FE9A00',
  'chart4': '#AD46FF',
  'chart5': '#FF2056',
  'sidebar': '#171717',
  'sidebarForeground': '#FAFAFA',
  'sidebarPrimary': '#1447E6',
  'sidebarPrimaryForeground': '#FAFAFA',
  'sidebarAccent': '#262626',
  'sidebarAccentForeground': '#FAFAFA',
  'sidebarBorder': '#FFFFFF1A',
  'sidebarRing': '#737373',
};

/// [kFallbackLightHex] parsed to ARGB.
final Map<String, int> kFallbackLight = <String, int>{
  for (final MapEntry<String, String> e in kFallbackLightHex.entries)
    e.key: _parseFallbackHex(e.value),
};

/// [kFallbackDarkHex] parsed to ARGB.
final Map<String, int> kFallbackDark = <String, int>{
  for (final MapEntry<String, String> e in kFallbackDarkHex.entries)
    e.key: _parseFallbackHex(e.value),
};

int _parseFallbackHex(String value) {
  final String digits = value.substring(1);
  final int rgb = int.parse(digits.substring(0, 6), radix: 16);
  final int alpha = digits.length == 8
      ? int.parse(digits.substring(6, 8), radix: 16)
      : 0xFF;
  return (alpha << 24) | rgb;
}
