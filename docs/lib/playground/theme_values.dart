// Typed theme control state for the live playground panel.
//
// A [PlaygroundThemeValues] holds token overrides for the page's preview
// and all its examples: radius (0-24 px + presets), density (compact,
// comfortable, touch), spacing base, tracking, shadow (none, sm, md, lg),
// surface opacity, surface blur, font (sans, serif, mono) and light/dark mode.
//
// Values serialize into the URL query as `t.<name>` parameters (non-default
// entries only) so a configured preview is shareable; [fromQuery] restores
// them. Defaults come from the ambient site theme.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/theme/density.dart';
import '../ui/dashcn/theme/density_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import '../ui/dashcn/theme/tokens.dart';
import '../ui/dashcn/theme/typography.dart';

/// Available density presets for the playground theme controls.
const List<String> kPlaygroundThemeDensities = <String>[
  'compact',
  'comfortable',
  'touch',
];

/// Available shadow presets for the playground theme controls.
const List<String> kPlaygroundThemeShadows = <String>['none', 'sm', 'md', 'lg'];

/// Available font options for the playground theme controls.
const List<String> kPlaygroundThemeFonts = <String>['sans', 'serif', 'mono'];

/// Available mode options for the playground theme controls.
const List<String> kPlaygroundThemeModes = <String>['light', 'dark'];

/// Radius presets in px for the playground theme controls.
const List<double> kPlaygroundThemeRadiusPresets = <double>[
  0,
  4,
  8,
  12,
  16,
  20,
  24,
];

/// Typed theme overrides configured in the playground panel.
class PlaygroundThemeValues {
  /// Creates the values.
  const PlaygroundThemeValues({
    required this.radius,
    required this.density,
    required this.spacingBase,
    required this.tracking,
    required this.shadow,
    required this.surfaceOpacity,
    required this.surfaceBlur,
    required this.font,
    required this.mode,
  });

  /// Seeds defaults matching [siteTheme].
  factory PlaygroundThemeValues.defaults(ThemeData siteTheme) {
    return PlaygroundThemeValues(
      radius: (siteTheme.tokens.radius * 16.0).clamp(0.0, 24.0),
      density: siteTheme.densityTokens.preset.name,
      spacingBase: siteTheme.tokens.spacingBase,
      tracking: siteTheme.tokens.trackingNormal,
      shadow: _detectShadowPreset(siteTheme.tokens.shadows),
      surfaceOpacity: siteTheme.surfaceOpacity ?? 1.0,
      surfaceBlur: siteTheme.surfaceBlur ?? 0.0,
      font: 'sans',
      mode: siteTheme.brightness == Brightness.dark ? 'dark' : 'light',
    );
  }

  /// Restores values from URL query parameters (`t.<name>` entries).
  ///
  /// Missing or invalid parameters fall back to [siteTheme] defaults.
  factory PlaygroundThemeValues.fromQuery(
    ThemeData siteTheme,
    Map<String, String> query,
  ) {
    final PlaygroundThemeValues def = PlaygroundThemeValues.defaults(siteTheme);
    final String? rRaw = query['t.radius'];
    final double radius = rRaw != null
        ? (double.tryParse(rRaw)?.clamp(0.0, 24.0) ?? def.radius)
        : def.radius;

    final String? dRaw = query['t.density'];
    final String density =
        (dRaw != null && kPlaygroundThemeDensities.contains(dRaw))
        ? dRaw
        : def.density;

    final String? sRaw = query['t.spacing'] ?? query['t.spacingBase'];
    final double spacingBase = sRaw != null
        ? (double.tryParse(sRaw)?.clamp(1.0, 32.0) ?? def.spacingBase)
        : def.spacingBase;

    final String? trRaw = query['t.tracking'];
    final double tracking = trRaw != null
        ? (double.tryParse(trRaw)?.clamp(-2.0, 8.0) ?? def.tracking)
        : def.tracking;

    final String? shRaw = query['t.shadow'];
    final String shadow =
        (shRaw != null && kPlaygroundThemeShadows.contains(shRaw))
        ? shRaw
        : def.shadow;

    final String? soRaw = query['t.surfaceOpacity'];
    final double surfaceOpacity = soRaw != null
        ? (double.tryParse(soRaw)?.clamp(0.0, 1.0) ?? def.surfaceOpacity)
        : def.surfaceOpacity;

    final String? sbRaw = query['t.surfaceBlur'];
    final double surfaceBlur = sbRaw != null
        ? (double.tryParse(sbRaw)?.clamp(0.0, 50.0) ?? def.surfaceBlur)
        : def.surfaceBlur;

    final String? fRaw = query['t.font'];
    final String font = (fRaw != null && kPlaygroundThemeFonts.contains(fRaw))
        ? fRaw
        : def.font;

    final String? mRaw = query['t.mode'] ?? query['t.brightness'];
    final String mode = (mRaw != null && kPlaygroundThemeModes.contains(mRaw))
        ? mRaw
        : def.mode;

    return PlaygroundThemeValues(
      radius: radius,
      density: density,
      spacingBase: spacingBase,
      tracking: tracking,
      shadow: shadow,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      font: font,
      mode: mode,
    );
  }

  /// Radius in logical px (0..24).
  final double radius;

  /// Density preset ('compact', 'comfortable', 'touch').
  final String density;

  /// Spacing base in logical px (e.g. 4.0).
  final double spacingBase;

  /// Tracking (letter spacing).
  final double tracking;

  /// Shadow preset ('none', 'sm', 'md', 'lg').
  final String shadow;

  /// Surface overlay opacity (0.0..1.0).
  final double surfaceOpacity;

  /// Surface blur radius in px (0..50).
  final double surfaceBlur;

  /// Font family option ('sans', 'serif', 'mono').
  final String font;

  /// Brightness mode ('light', 'dark').
  final String mode;

  /// Copies with overrides.
  PlaygroundThemeValues copyWith({
    double? radius,
    String? density,
    double? spacingBase,
    double? tracking,
    String? shadow,
    double? surfaceOpacity,
    double? surfaceBlur,
    String? font,
    String? mode,
  }) {
    return PlaygroundThemeValues(
      radius: radius ?? this.radius,
      density: density ?? this.density,
      spacingBase: spacingBase ?? this.spacingBase,
      tracking: tracking ?? this.tracking,
      shadow: shadow ?? this.shadow,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      font: font ?? this.font,
      mode: mode ?? this.mode,
    );
  }

  /// Whether all tokens match [siteTheme] defaults.
  bool isDefault(ThemeData siteTheme) {
    return toQuery(siteTheme).isEmpty;
  }

  /// URL query parameters (`t.<name>`), only for non-default entries.
  Map<String, String> toQuery(ThemeData siteTheme) {
    final PlaygroundThemeValues def = PlaygroundThemeValues.defaults(siteTheme);
    final Map<String, String> out = <String, String>{};

    if ((radius - def.radius).abs() > 0.05) {
      out['t.radius'] = _fmtNum(radius);
    }
    if (density != def.density) {
      out['t.density'] = density;
    }
    if ((spacingBase - def.spacingBase).abs() > 0.05) {
      out['t.spacing'] = _fmtNum(spacingBase);
    }
    if ((tracking - def.tracking).abs() > 0.01) {
      out['t.tracking'] = _fmtNum(tracking);
    }
    if (shadow != def.shadow) {
      out['t.shadow'] = shadow;
    }
    if ((surfaceOpacity - def.surfaceOpacity).abs() > 0.01) {
      out['t.surfaceOpacity'] = surfaceOpacity.toStringAsFixed(2);
    }
    if ((surfaceBlur - def.surfaceBlur).abs() > 0.05) {
      out['t.surfaceBlur'] = _fmtNum(surfaceBlur);
    }
    if (font != def.font) {
      out['t.font'] = font;
    }
    if (mode != def.mode) {
      out['t.mode'] = mode;
    }

    return out;
  }

  /// Produces a modified [ThemeData] applying these overrides to [siteTheme].
  ThemeData applyTo(
    ThemeData siteTheme,
    ThemeData Function(Brightness) themeFor,
  ) {
    final Brightness targetBrightness = mode == 'dark'
        ? Brightness.dark
        : Brightness.light;
    final ThemeData base = themeFor(targetBrightness);

    final DensityTokens dTokens = switch (density) {
      'comfortable' => DensityTokens.comfortable,
      'touch' => DensityTokens.touch,
      _ => DensityTokens.compact,
    };

    final Density d = switch (density) {
      'comfortable' => Density.defaultDensity,
      'touch' => Density.spaciousDensity,
      _ => Density.compactDensity,
    };

    final ShadowScale shadows = switch (shadow) {
      'none' => const ShadowScale(
        shadow2xs: <BoxShadow>[],
        shadowXs: <BoxShadow>[],
        shadowSm: <BoxShadow>[],
        shadow: <BoxShadow>[],
        shadowMd: <BoxShadow>[],
        shadowLg: <BoxShadow>[],
        shadowXl: <BoxShadow>[],
        shadow2xl: <BoxShadow>[],
      ),
      'sm' => ShadowScale.derive(
        opacity: 0.06,
        blur: 8,
        spread: -10,
        offsetY: 4,
      ),
      'lg' => ShadowScale.derive(
        opacity: 0.25,
        blur: 32,
        spread: -20,
        offsetY: 16,
      ),
      _ => defaultShadowScale,
    };

    final String targetFamily = switch (font) {
      'serif' => base.fonts.fontSerif ?? 'Lora',
      'mono' => base.fonts.fontMono ?? 'GeistMono',
      _ => base.fonts.fontSans ?? 'GeistSans',
    };

    final ThemeFonts nextFonts = base.fonts.copyWith(
      fontSans: () => targetFamily,
    );
    final Typography nextTypography = base.typography.applyFonts(nextFonts);

    final DesignTokens tokens = base.tokens.copyWith(
      radius: radius / 16.0,
      spacingBase: spacingBase,
      trackingNormal: tracking,
      shadows: shadows,
    );

    return base.copyWith(
      tokens: () => tokens,
      fonts: () => nextFonts,
      typography: () => nextTypography,
      densityTokens: () => dTokens,
      density: () => d,
      spacing: () => SpacingScale(spacingBase),
      tracking: () => TrackingScale(normal: tracking),
      surfaceOpacity: () => surfaceOpacity,
      surfaceBlur: () => surfaceBlur,
    );
  }

  static String _detectShadowPreset(ShadowScale scale) {
    if (scale.shadowSm.isEmpty && scale.shadowLg.isEmpty) {
      return 'none';
    }
    return 'md';
  }

  static String _fmtNum(double n) {
    if (n == n.roundToDouble()) {
      return n.round().toString();
    }
    return n.toStringAsFixed(1);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaygroundThemeValues &&
          other.radius == radius &&
          other.density == density &&
          other.spacingBase == spacingBase &&
          other.tracking == tracking &&
          other.shadow == shadow &&
          other.surfaceOpacity == surfaceOpacity &&
          other.surfaceBlur == surfaceBlur &&
          other.font == font &&
          other.mode == mode;

  @override
  int get hashCode => Object.hash(
    radius,
    density,
    spacingBase,
    tracking,
    shadow,
    surfaceOpacity,
    surfaceBlur,
    font,
    mode,
  );

  @override
  String toString() =>
      'PlaygroundThemeValues(radius: $radius, density: $density, spacingBase: $spacingBase, tracking: $tracking, shadow: $shadow, surfaceOpacity: $surfaceOpacity, surfaceBlur: $surfaceBlur, font: $font, mode: $mode)';
}
