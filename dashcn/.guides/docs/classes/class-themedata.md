---
title: "Class: ThemeData"
description: "Ambient upstream theme data: colors, tokens, fonts, typography and flags."
---

```dart
/// Ambient upstream theme data: colors, tokens, fonts, typography and flags.
class ThemeData {
  const ThemeData({this.colors = ThemeColors.lightFallback, this.tokens = const DesignTokens(), this.fonts = ThemeFonts.empty, this.typography = const Typography.geist(), this.iconTheme = const IconThemeProperties(), this.scaling = 1, this.density = Density.defaultDensity, this.spacing = const SpacingScale(4.0), this.tracking = const TrackingScale(), this._platform, this.surfaceOpacity, this.surfaceBlur, this.enableFeedback, this.syntax});
  /// Color tokens for the current brightness.
  final ThemeColors colors;
  /// Non-color tokens (radius factor, spacing base, tracking, shadows).
  final DesignTokens tokens;
  /// Mode-independent font families.
  final ThemeFonts fonts;
  /// Text styles.
  final Typography typography;
  /// Icon sizes.
  final IconThemeProperties iconTheme;
  /// Global size scaling factor.
  final double scaling;
  /// Container/content padding and gap bases.
  final Density density;
  /// Spacing scale for padding/margins.
  final SpacingScale spacing;
  /// Letter-spacing scale.
  final TrackingScale tracking;
  /// Surface overlay opacity for popups/cards (read by surface components).
  final double? surfaceOpacity;
  /// Surface blur radius for popups/cards.
  final double? surfaceBlur;
  /// Haptic/sound feedback toggle for interactive controls.
  final bool? enableFeedback;
  /// Syntax-highlight palette override. Null (the default) resolves
  /// [syntaxColors] from the ambient brightness, so every preset works with
  /// no per-preset JSON edits; set it to pin a custom palette.
  final SyntaxColors? syntax;
  /// Effective syntax-highlight palette for the current brightness.
  SyntaxColors get syntaxColors;
  /// Effective platform (override or ambient default).
  TargetPlatform get platform;
  /// Explicit platform override, if any.
  TargetPlatform? get specifiedPlatform;
  /// Current brightness, from the color tokens.
  Brightness get brightness;
  /// Base radius factor: the preset `radius` rem number (e.g. 0.625).
  ///
  /// Derived steps follow upstream `globals.css`: `lg` is the rem value in
  /// px (`radius * 16`); `sm`/`md` step down 4/2 px and `xl` steps up
  /// 4 px, clamped at zero so small radii (and 0) never go negative.
  /// `xl` additionally collapses to 0 when `lg` is 0, so square-corner
  /// presets (`radius: 0`) stay square on `rounded-xl` surfaces too.
  /// `xs`/`xxl` are kit extensions that keep the old linear steps.
  double get radius;
  double get radiusXs;
  double get radiusSm;
  double get radiusMd;
  double get radiusLg;
  double get radiusXl;
  double get radiusXxl;
  BorderRadius get borderRadiusXs;
  BorderRadius get borderRadiusSm;
  BorderRadius get borderRadiusMd;
  BorderRadius get borderRadiusLg;
  BorderRadius get borderRadiusXl;
  BorderRadius get borderRadiusXxl;
  ThemeData copyWith({ValueGetter<ThemeColors>? colors, ValueGetter<DesignTokens>? tokens, ValueGetter<ThemeFonts>? fonts, ValueGetter<Typography>? typography, ValueGetter<IconThemeProperties>? iconTheme, ValueGetter<double>? scaling, ValueGetter<Density>? density, ValueGetter<SpacingScale>? spacing, ValueGetter<TrackingScale>? tracking, ValueGetter<TargetPlatform>? platform, ValueGetter<double>? surfaceOpacity, ValueGetter<double>? surfaceBlur, ValueGetter<bool>? enableFeedback, ValueGetter<SyntaxColors?>? syntax});
  static ThemeData lerp(ThemeData a, ThemeData b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
