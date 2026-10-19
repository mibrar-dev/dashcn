// Registry-owned theme data for the `wheel_picker` component: the
// [WheelPickerTheme] container and the token-derived `wheelPickerDefaults`.
//
// User-owned overrides live in `wheel_picker_theme.dart`; CLI updates may
// replace this file. The widget resolves the four legs through
// `resolveComponentStyle<WheelPickerTheme, WheelPickerTheme>` from
// `theme/theme.dart`.

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// One wheel picker's visual contract.
///
/// Every field is nullable, so an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `selectionBorderRadius`
/// resolves at build because its default follows the theme's radius token.
class WheelPickerTheme extends ComponentThemeData
    implements Mergeable<WheelPickerTheme> {
  /// Creates a wheel picker theme.
  const WheelPickerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.itemHeight,
    this.visibleItems,
    this.selectionColor,
    this.selectionBorderColor,
    this.selectionBorderWidth,
    this.selectionBorderRadius,
    this.foreground,
    this.mutedForeground,
    this.fontSize,
    this.fontWeight,
    this.fadeColor,
    this.fadeHeight,
    this.perspective,
    this.diameterRatio,
    this.surfaceColor,
    this.borderRadius,
    this.separatorColor,
    this.separatorWidth,
  });

  /// Height of one wheel row; null resolves 40.
  final double? itemHeight;

  /// Number of rows the wheel shows; null resolves 5 (odd, so the selection
  /// band centres on a row).
  final int? visibleItems;

  /// Fill of the centred selection band; null resolves `accent` at 12% alpha.
  final ThemedColor? selectionColor;

  /// Border colour of the selection band; null resolves the `border` token.
  final ThemedColor? selectionBorderColor;

  /// Border width of the selection band; null resolves 1.
  final double? selectionBorderWidth;

  /// Corner radius of the selection band; null resolves `radiusMd`.
  final BorderRadiusGeometry? selectionBorderRadius;

  /// Text colour of the selected row; null resolves the `foreground` token.
  final ThemedColor? foreground;

  /// Text colour of the unselected rows; null resolves `mutedForeground`.
  final ThemedColor? mutedForeground;

  /// Row font size; null resolves 16.
  final double? fontSize;

  /// Font weight of the selected row; null resolves w600.
  final FontWeight? fontWeight;

  /// Base colour of the top/bottom edge fades; null resolves `background`.
  final ThemedColor? fadeColor;

  /// Height of each edge fade; null resolves 32.
  final double? fadeHeight;

  /// 3D cylinder amount used when the widget's `perspective` flag is on; null
  /// resolves 0.003. Ignored when the flag is off (flat wheel).
  final double? perspective;

  /// Diameter ratio of the 3D cylinder; null resolves 1.6.
  final double? diameterRatio;

  /// Fill of the wheel container; null resolves the `background` token.
  final ThemedColor? surfaceColor;

  /// Corner radius of the wheel container; null resolves `radiusLg`.
  final BorderRadiusGeometry? borderRadius;

  /// Colour of the vertical column separators; null resolves `border`.
  final ThemedColor? separatorColor;

  /// Width of the column separators; null resolves 1.
  final double? separatorWidth;

  /// Returns a copy with the given fields replaced.
  WheelPickerTheme copyWith({
    ValueGetter<double?>? itemHeight,
    ValueGetter<int?>? visibleItems,
    ValueGetter<ThemedColor?>? selectionColor,
    ValueGetter<ThemedColor?>? selectionBorderColor,
    ValueGetter<double?>? selectionBorderWidth,
    ValueGetter<BorderRadiusGeometry?>? selectionBorderRadius,
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? mutedForeground,
    ValueGetter<double?>? fontSize,
    ValueGetter<FontWeight?>? fontWeight,
    ValueGetter<ThemedColor?>? fadeColor,
    ValueGetter<double?>? fadeHeight,
    ValueGetter<double?>? perspective,
    ValueGetter<double?>? diameterRatio,
    ValueGetter<ThemedColor?>? surfaceColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<ThemedColor?>? separatorColor,
    ValueGetter<double?>? separatorWidth,
  }) {
    return WheelPickerTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      itemHeight: itemHeight == null ? this.itemHeight : itemHeight(),
      visibleItems: visibleItems == null ? this.visibleItems : visibleItems(),
      selectionColor:
          selectionColor == null ? this.selectionColor : selectionColor(),
      selectionBorderColor: selectionBorderColor == null
          ? this.selectionBorderColor
          : selectionBorderColor(),
      selectionBorderWidth: selectionBorderWidth == null
          ? this.selectionBorderWidth
          : selectionBorderWidth(),
      selectionBorderRadius: selectionBorderRadius == null
          ? this.selectionBorderRadius
          : selectionBorderRadius(),
      foreground: foreground == null ? this.foreground : foreground(),
      mutedForeground:
          mutedForeground == null ? this.mutedForeground : mutedForeground(),
      fontSize: fontSize == null ? this.fontSize : fontSize(),
      fontWeight: fontWeight == null ? this.fontWeight : fontWeight(),
      fadeColor: fadeColor == null ? this.fadeColor : fadeColor(),
      fadeHeight: fadeHeight == null ? this.fadeHeight : fadeHeight(),
      perspective: perspective == null ? this.perspective : perspective(),
      diameterRatio: diameterRatio == null ? this.diameterRatio : diameterRatio(),
      surfaceColor: surfaceColor == null ? this.surfaceColor : surfaceColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      separatorColor:
          separatorColor == null ? this.separatorColor : separatorColor(),
      separatorWidth:
          separatorWidth == null ? this.separatorWidth : separatorWidth(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  WheelPickerTheme merge(WheelPickerTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return WheelPickerTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      itemHeight: itemHeight ?? fallback.itemHeight,
      visibleItems: visibleItems ?? fallback.visibleItems,
      selectionColor: selectionColor ?? fallback.selectionColor,
      selectionBorderColor: selectionBorderColor ?? fallback.selectionBorderColor,
      selectionBorderWidth: selectionBorderWidth ?? fallback.selectionBorderWidth,
      selectionBorderRadius: selectionBorderRadius ?? fallback.selectionBorderRadius,
      foreground: foreground ?? fallback.foreground,
      mutedForeground: mutedForeground ?? fallback.mutedForeground,
      fontSize: fontSize ?? fallback.fontSize,
      fontWeight: fontWeight ?? fallback.fontWeight,
      fadeColor: fadeColor ?? fallback.fadeColor,
      fadeHeight: fadeHeight ?? fallback.fadeHeight,
      perspective: perspective ?? fallback.perspective,
      diameterRatio: diameterRatio ?? fallback.diameterRatio,
      surfaceColor: surfaceColor ?? fallback.surfaceColor,
      borderRadius: borderRadius ?? fallback.borderRadius,
      separatorColor: separatorColor ?? fallback.separatorColor,
      separatorWidth: separatorWidth ?? fallback.separatorWidth,
    );
  }

  /// Discrete fields step at t < 0.5, matching the other component themes.
  static WheelPickerTheme lerp(WheelPickerTheme a, WheelPickerTheme b, double t) {
    return WheelPickerTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      itemHeight: t < 0.5 ? a.itemHeight : b.itemHeight,
      visibleItems: t < 0.5 ? a.visibleItems : b.visibleItems,
      selectionColor: t < 0.5 ? a.selectionColor : b.selectionColor,
      selectionBorderColor: t < 0.5 ? a.selectionBorderColor : b.selectionBorderColor,
      selectionBorderWidth: t < 0.5 ? a.selectionBorderWidth : b.selectionBorderWidth,
      selectionBorderRadius: t < 0.5 ? a.selectionBorderRadius : b.selectionBorderRadius,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      mutedForeground: t < 0.5 ? a.mutedForeground : b.mutedForeground,
      fontSize: t < 0.5 ? a.fontSize : b.fontSize,
      fontWeight: t < 0.5 ? a.fontWeight : b.fontWeight,
      fadeColor: t < 0.5 ? a.fadeColor : b.fadeColor,
      fadeHeight: t < 0.5 ? a.fadeHeight : b.fadeHeight,
      perspective: t < 0.5 ? a.perspective : b.perspective,
      diameterRatio: t < 0.5 ? a.diameterRatio : b.diameterRatio,
      surfaceColor: t < 0.5 ? a.surfaceColor : b.surfaceColor,
      borderRadius: t < 0.5 ? a.borderRadius : b.borderRadius,
      separatorColor: t < 0.5 ? a.separatorColor : b.separatorColor,
      separatorWidth: t < 0.5 ? a.separatorWidth : b.separatorWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is WheelPickerTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.itemHeight == itemHeight &&
        other.visibleItems == visibleItems &&
        other.selectionColor == selectionColor &&
        other.selectionBorderColor == selectionBorderColor &&
        other.selectionBorderWidth == selectionBorderWidth &&
        other.selectionBorderRadius == selectionBorderRadius &&
        other.foreground == foreground &&
        other.mutedForeground == mutedForeground &&
        other.fontSize == fontSize &&
        other.fontWeight == fontWeight &&
        other.fadeColor == fadeColor &&
        other.fadeHeight == fadeHeight &&
        other.perspective == perspective &&
        other.diameterRatio == diameterRatio &&
        other.surfaceColor == surfaceColor &&
        other.borderRadius == borderRadius &&
        other.separatorColor == separatorColor &&
        other.separatorWidth == separatorWidth;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    itemHeight,
    visibleItems,
    selectionColor,
    selectionBorderColor,
    selectionBorderWidth,
    selectionBorderRadius,
    foreground,
    mutedForeground,
    fontSize,
    fontWeight,
    fadeColor,
    fadeHeight,
    perspective,
    diameterRatio,
    surfaceColor,
    borderRadius,
    separatorColor,
    separatorWidth,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
///
/// `selectionBorderRadius` and `borderRadius` stay null so they resolve from
/// the ambient radius token rather than freezing a value here.
const WheelPickerTheme wheelPickerDefaults = WheelPickerTheme(
  itemHeight: 40,
  visibleItems: 5,
  selectionColor: ThemedColor.ref(ColorRef.accent, alpha: 0.12),
  selectionBorderColor: ThemedColor.ref(ColorRef.border),
  selectionBorderWidth: 1,
  foreground: ThemedColor.ref(ColorRef.foreground),
  mutedForeground: ThemedColor.ref(ColorRef.mutedForeground),
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fadeColor: ThemedColor.ref(ColorRef.background),
  fadeHeight: 32,
  perspective: 0.003,
  diameterRatio: 1.6,
  surfaceColor: ThemedColor.ref(ColorRef.background),
  separatorColor: ThemedColor.ref(ColorRef.border),
  separatorWidth: 1,
);

/// Default snap animation for programmatic selection changes.
const Duration kWheelPickerSnapDuration = kDefaultDuration;

/// Curve for programmatic selection changes.
const Curve kWheelPickerSnapCurve = Curves.easeOutCubic;
