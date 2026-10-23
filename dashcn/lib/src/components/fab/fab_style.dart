// Registry-owned theme data for the `fab` component: the per-instance
// [FabStyle] slice, the size/shape tables and the token-derived defaults.
//
// The component theme container ([FabTheme]) and the default rows live in
// `fab_defaults.dart`; this file re-exports them so a caller (including the
// user-owned `fab_theme.dart`) only needs one import.
//
// User-owned overrides live in `fab_theme.dart`, which imports only this
// file; CLI updates may replace that file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';

export 'fab_defaults.dart';

/// Fixed sizes of the floating action button.
///
/// The button box follows Material 3 FAB sizes (small 40, medium 56, large
/// 64; mini 32/40/48), so the painted button is larger than a compact
/// 32 px control by design — it is a floating surface, not an inline
/// control. The mini sizes match the density tokens exactly (32 compact,
/// 40 comfortable, 48 touch). The touch target grows past them on touch
/// platforms (the `TapTarget` primitive), so the painted button never
/// changes.
enum FabSize {
  /// 40 x 40 with a 16 px icon (density compact icon).
  sm,

  /// 56 x 56 with a 20 px icon (density comfortable icon; the default).
  md,

  /// 64 x 64 with a 24 px icon (density touch icon).
  lg,
}

/// The shape of a floating action button.
enum FabShape {
  /// Round, icon only.
  standard,

  /// Pill, icon plus label.
  extended,

  /// Small round button (a speed-dial mini action).
  mini,
}

/// The button box for [size] in [shape], in logical pixels.
double fabBoxFor(FabSize size, FabShape shape) {
  if (shape == FabShape.mini) {
    return switch (size) {
      FabSize.sm => 32,
      FabSize.md => 40,
      FabSize.lg => 48,
    };
  }
  return switch (size) {
    FabSize.sm => 40,
    FabSize.md => 56,
    FabSize.lg => 64,
  };
}

/// The icon size for [size] in [shape], in logical pixels.
///
/// Compact token 16 for small and for every extended pill (the default
/// extended 56 px pill carries a 16 px icon plus label, same on desktop
/// and mobile); standard round keeps the density steps (16 / 20 / 24) and
/// mini follows the tokens. Icons never exceed 60% of the button box.
double fabIconFor(FabSize size, FabShape shape) {
  if (shape == FabShape.extended) {
    return 16;
  }
  return switch (size) {
    FabSize.sm => 16,
    FabSize.md => 20,
    FabSize.lg => 24,
  };
}

/// One floating action button's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class FabStyle implements Mergeable<FabStyle> {
  /// Creates a floating action button style slice.
  const FabStyle({
    this.background,
    this.foreground,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.labelPadding,
    this.gap,
    this.textStyle,
    this.iconSize,
    this.borderRadius,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.size,
  });

  /// Per-state fill of the button surface.
  final StateValue<ThemedColor>? background;

  /// Per-state icon/label colour.
  final StateValue<ThemedColor>? foreground;

  /// Per-state border colour; null draws no border.
  final StateValue<ThemedColor>? borderColor;

  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;

  /// Shadow colour; null falls back to the ambient token shadow colour.
  final ThemedColor? shadowColor;

  /// Shadow strength (0 paints no shadow).
  final double? elevation;

  /// Padding inside the button box; null uses the size table's padding.
  final EdgeInsetsGeometry? padding;

  /// Padding between the icon and the label of an extended button.
  final EdgeInsetsGeometry? labelPadding;

  /// Gap between the icon and the label of an extended button.
  final double? gap;

  /// Label text style; its colour is taken from [foreground].
  final TextStyle? textStyle;

  /// Icon size; null uses [fabIconFor].
  final double? iconSize;

  /// Corner radius; null uses a circle for the round shapes and the
  /// ambient `borderRadiusLg` for the extended pill.
  final BorderRadiusGeometry? borderRadius;

  /// Surface opacity override for the floating fill; null follows the
  /// ambient `ThemeData.surfaceOpacity`.
  final double? surfaceOpacity;

  /// Surface blur override for the floating fill; null follows the ambient
  /// `ThemeData.surfaceBlur`.
  final double? surfaceBlur;

  /// Box size override; null uses [fabBoxFor].
  final double? size;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  FabStyle merge(FabStyle? fallback) {
    if (fallback == null) {
      return this;
    }
    return FabStyle(
      background: background?.merge(fallback.background) ?? fallback.background,
      foreground: foreground?.merge(fallback.foreground) ?? fallback.foreground,
      borderColor:
          borderColor?.merge(fallback.borderColor) ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      shadowColor: shadowColor ?? fallback.shadowColor,
      elevation: elevation ?? fallback.elevation,
      padding: padding ?? fallback.padding,
      labelPadding: labelPadding ?? fallback.labelPadding,
      gap: gap ?? fallback.gap,
      textStyle: textStyle == null
          ? fallback.textStyle
          : (fallback.textStyle?.merge(textStyle) ?? textStyle),
      iconSize: iconSize ?? fallback.iconSize,
      borderRadius: borderRadius ?? fallback.borderRadius,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
      size: size ?? fallback.size,
    );
  }

  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static FabStyle lerp(FabStyle a, FabStyle b, double t) {
    return FabStyle(
      background: t < 0.5 ? a.background : b.background,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      shadowColor: t < 0.5 ? a.shadowColor : b.shadowColor,
      elevation: lerpDouble(a.elevation, b.elevation, t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      labelPadding: EdgeInsetsGeometry.lerp(a.labelPadding, b.labelPadding, t),
      gap: lerpDouble(a.gap, b.gap, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      iconSize: lerpDouble(a.iconSize, b.iconSize, t),
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      surfaceOpacity: lerpDouble(a.surfaceOpacity, b.surfaceOpacity, t),
      surfaceBlur: lerpDouble(a.surfaceBlur, b.surfaceBlur, t),
      size: lerpDouble(a.size, b.size, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FabStyle &&
        other.background == background &&
        other.foreground == foreground &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.shadowColor == shadowColor &&
        other.elevation == elevation &&
        other.padding == padding &&
        other.labelPadding == labelPadding &&
        other.gap == gap &&
        other.textStyle == textStyle &&
        other.iconSize == iconSize &&
        other.borderRadius == borderRadius &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.size == size;
  }

  @override
  int get hashCode => Object.hash(
    background,
    foreground,
    borderColor,
    borderWidth,
    shadowColor,
    elevation,
    padding,
    labelPadding,
    gap,
    textStyle,
    iconSize,
    borderRadius,
    surfaceOpacity,
    surfaceBlur,
    size,
  );
}
