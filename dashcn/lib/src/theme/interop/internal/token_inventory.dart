// Unexported kit token inventory and fallback values (pure Dart).
//
// Canonical home of the 32 colour tokens (in preset-schema order) and the
// neutral-preset fallbacks an import falls back to for anything the source
// does not name. Not exported by `interop.dart` (or any barrel): import it
// directly from `src/` when working inside the interop layer.

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
