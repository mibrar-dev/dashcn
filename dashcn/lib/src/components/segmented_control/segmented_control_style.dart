// Registry-owned theme data for the `segmented_control` component: the
// per-instance [SegmentedControlStyle] slice, the size enums and the size
// tables.
//
// The component theme container ([SegmentedControlTheme]) and the default
// rows live in `segmented_control_defaults.dart`; this file re-exports them
// so a caller (including the user-owned `segmented_control_theme.dart`) only
// needs one import.
//
// User-owned overrides live in `segmented_control_theme.dart`, which imports
// only this file; CLI updates may replace that file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';

export 'segmented_control_defaults.dart';

/// Fixed sizes of a segmented control.
enum SegmentedControlSize {
  /// 28 px tall with a 14 px icon.
  sm,

  /// 32 px tall with a 16 px icon (the default).
  md,

  /// 36 px tall with a 18 px icon.
  lg,
}

/// The height of a segmented control for [size], in logical pixels.
double segmentedControlHeightFor(SegmentedControlSize size) {
  return switch (size) {
    SegmentedControlSize.sm => 28,
    SegmentedControlSize.md => 32,
    SegmentedControlSize.lg => 36,
  };
}

/// The icon size of a segmented control for [size], in logical pixels.
double segmentedControlIconFor(SegmentedControlSize size) {
  return switch (size) {
    SegmentedControlSize.sm => 14,
    SegmentedControlSize.md => 16,
    SegmentedControlSize.lg => 18,
  };
}

/// How many segments a segmented control selects at once.
enum SegmentedControlSelection {
  /// One segment at a time (the default).
  single,

  /// Any number of segments.
  multiple,
}

/// One segmented control's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class SegmentedControlStyle implements Mergeable<SegmentedControlStyle> {
  /// Creates a segmented control style slice.
  const SegmentedControlStyle({
    this.background,
    this.thumbBackground,
    this.thumbBorderColor,
    this.thumbBorderWidth,
    this.foreground,
    this.selectedForeground,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.segmentPadding,
    this.gap,
    this.textStyle,
    this.iconSize,
    this.height,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.shadows,
  });

  /// The control's own fill (the track behind the segments).
  final ThemedColor? background;

  /// The fill of the sliding thumb.
  final ThemedColor? thumbBackground;

  /// The border colour of the sliding thumb.
  final ThemedColor? thumbBorderColor;

  /// The border width of the sliding thumb.
  final double? thumbBorderWidth;

  /// The colour of an unselected segment's icon and label.
  final StateValue<ThemedColor>? foreground;

  /// The colour of a selected segment's icon and label.
  final StateValue<ThemedColor>? selectedForeground;

  /// The control's border colour; null draws no border.
  final ThemedColor? borderColor;

  /// The control's border width; null uses 1 px when a border colour is set.
  final double? borderWidth;

  /// The control's corner radius; null uses the ambient `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;

  /// The control's padding; null uses 3 px.
  final EdgeInsetsGeometry? padding;

  /// The padding inside a segment; null uses 8 px horizontally.
  final EdgeInsetsGeometry? segmentPadding;

  /// The gap between two segments; null uses zero.
  final double? gap;

  /// The label style; its colour comes from the foreground legs.
  final TextStyle? textStyle;

  /// The icon size; null uses [segmentedControlIconFor].
  final double? iconSize;

  /// The control's height; null uses [segmentedControlHeightFor].
  final double? height;

  /// The surface opacity override for the track.
  final double? surfaceOpacity;

  /// The surface blur override for the track.
  final double? surfaceBlur;

  /// The control's shadow.
  final List<BoxShadow>? shadows;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SegmentedControlStyle merge(SegmentedControlStyle? fallback) {
    if (fallback == null) {
      return this;
    }
    return SegmentedControlStyle(
      background: background ?? fallback.background,
      thumbBackground: thumbBackground ?? fallback.thumbBackground,
      thumbBorderColor: thumbBorderColor ?? fallback.thumbBorderColor,
      thumbBorderWidth: thumbBorderWidth ?? fallback.thumbBorderWidth,
      foreground: foreground?.merge(fallback.foreground) ?? fallback.foreground,
      selectedForeground:
          selectedForeground?.merge(fallback.selectedForeground) ??
          fallback.selectedForeground,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      segmentPadding: segmentPadding ?? fallback.segmentPadding,
      gap: gap ?? fallback.gap,
      textStyle: textStyle == null
          ? fallback.textStyle
          : (fallback.textStyle?.merge(textStyle) ?? textStyle),
      iconSize: iconSize ?? fallback.iconSize,
      height: height ?? fallback.height,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
      shadows: shadows ?? fallback.shadows,
    );
  }

  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static SegmentedControlStyle lerp(
    SegmentedControlStyle a,
    SegmentedControlStyle b,
    double t,
  ) {
    return SegmentedControlStyle(
      background: t < 0.5 ? a.background : b.background,
      thumbBackground: t < 0.5 ? a.thumbBackground : b.thumbBackground,
      thumbBorderColor: t < 0.5 ? a.thumbBorderColor : b.thumbBorderColor,
      thumbBorderWidth: lerpDouble(a.thumbBorderWidth, b.thumbBorderWidth, t),
      foreground: t < 0.5 ? a.foreground : b.foreground,
      selectedForeground: t < 0.5 ? a.selectedForeground : b.selectedForeground,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      segmentPadding: EdgeInsetsGeometry.lerp(
        a.segmentPadding,
        b.segmentPadding,
        t,
      ),
      gap: lerpDouble(a.gap, b.gap, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      iconSize: lerpDouble(a.iconSize, b.iconSize, t),
      height: lerpDouble(a.height, b.height, t),
      surfaceOpacity: lerpDouble(a.surfaceOpacity, b.surfaceOpacity, t),
      surfaceBlur: lerpDouble(a.surfaceBlur, b.surfaceBlur, t),
      shadows: t < 0.5 ? a.shadows : b.shadows,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SegmentedControlStyle &&
        other.background == background &&
        other.thumbBackground == thumbBackground &&
        other.thumbBorderColor == thumbBorderColor &&
        other.thumbBorderWidth == thumbBorderWidth &&
        other.foreground == foreground &&
        other.selectedForeground == selectedForeground &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.segmentPadding == segmentPadding &&
        other.gap == gap &&
        other.textStyle == textStyle &&
        other.iconSize == iconSize &&
        other.height == height &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.shadows == shadows;
  }

  @override
  int get hashCode => Object.hash(
    background,
    thumbBackground,
    thumbBorderColor,
    thumbBorderWidth,
    foreground,
    selectedForeground,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    segmentPadding,
    gap,
    textStyle,
    iconSize,
    height,
    surfaceOpacity,
    surfaceBlur,
    shadows,
  );
}
