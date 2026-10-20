// Registry-owned theme data for the `toolbar` component: the per-instance
// [ToolbarStyle] slice, the axis/size enums and the item size tables.
//
// The component theme container ([ToolbarTheme]) and the default rows live in
// `toolbar_defaults.dart`; this file re-exports them so a caller (including
// the user-owned `toolbar_theme.dart`) only needs one import.
//
// User-owned overrides live in `toolbar_theme.dart`, which imports only this
// file; CLI updates may replace that file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';

export 'toolbar_defaults.dart';

/// The direction a toolbar lays its items out in.
enum ToolbarAxis {
  /// Items sit in a row.
  horizontal,

  /// Items sit in a column.
  vertical,
}

/// Fixed sizes of a toolbar's items.
enum ToolbarSize {
  /// 32 px items with a 16 px icon.
  sm,

  /// 36 px items with an 18 px icon.
  md,

  /// 40 px items with a 20 px icon.
  lg,
}

/// The item box for [size], in logical pixels.
double toolbarItemBoxFor(ToolbarSize size) {
  return switch (size) {
    ToolbarSize.sm => 32,
    ToolbarSize.md => 36,
    ToolbarSize.lg => 40,
  };
}

/// The icon size for [size], in logical pixels.
double toolbarIconFor(ToolbarSize size) {
  return switch (size) {
    ToolbarSize.sm => 16,
    ToolbarSize.md => 18,
    ToolbarSize.lg => 20,
  };
}

/// One toolbar's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields. The container leg
/// uses the container fields, the item leg the item fields, and so on.
class ToolbarStyle implements Mergeable<ToolbarStyle> {
  /// Creates a toolbar style slice.
  const ToolbarStyle({
    this.background,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.gap,
    this.itemSize,
    this.itemPadding,
    this.iconSize,
    this.textStyle,
    this.itemBackground,
    this.itemForeground,
    this.separatorColor,
    this.separatorThickness,
    this.groupBackground,
    this.groupBorderRadius,
    this.groupPadding,
    this.shadows,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  /// Container fill; null draws no fill.
  final ThemedColor? background;

  /// Container border colour; null draws no border.
  final ThemedColor? borderColor;

  /// Container border width used when [borderColor] resolves non-null.
  final double? borderWidth;

  /// Container corner radius; null uses the ambient `borderRadiusLg`.
  final BorderRadiusGeometry? borderRadius;

  /// Container padding; null uses the default padding.
  final EdgeInsetsGeometry? padding;

  /// Space between two items; null uses the theme's small spacing.
  final double? gap;

  /// The item's square box size; null uses [toolbarItemBoxFor].
  final double? itemSize;

  /// Padding inside an item; null uses the default padding.
  final EdgeInsetsGeometry? itemPadding;

  /// Icon size inside an item; null uses [toolbarIconFor].
  final double? iconSize;

  /// Item label style; its colour is taken from [itemForeground].
  final TextStyle? textStyle;

  /// Per-state fill of an item.
  final StateValue<ThemedColor>? itemBackground;

  /// Per-state icon/label colour of an item.
  final StateValue<ThemedColor>? itemForeground;

  /// Separator colour; null uses the ambient border token.
  final ThemedColor? separatorColor;

  /// Separator thickness; null uses 1 px.
  final double? separatorThickness;

  /// Group fill; null draws no fill.
  final ThemedColor? groupBackground;

  /// Group corner radius; null uses the ambient `borderRadiusMd`.
  final BorderRadiusGeometry? groupBorderRadius;

  /// Padding inside a group.
  final EdgeInsetsGeometry? groupPadding;

  /// Container shadow; null uses the ambient shadow scale.
  final List<BoxShadow>? shadows;

  /// Surface opacity override for the container fill.
  final double? surfaceOpacity;

  /// Surface blur override for the container fill.
  final double? surfaceBlur;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ToolbarStyle merge(ToolbarStyle? fallback) {
    if (fallback == null) {
      return this;
    }
    return ToolbarStyle(
      background: background ?? fallback.background,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      gap: gap ?? fallback.gap,
      itemSize: itemSize ?? fallback.itemSize,
      itemPadding: itemPadding ?? fallback.itemPadding,
      iconSize: iconSize ?? fallback.iconSize,
      textStyle: textStyle == null
          ? fallback.textStyle
          : (fallback.textStyle?.merge(textStyle) ?? textStyle),
      itemBackground:
          itemBackground?.merge(fallback.itemBackground) ??
          fallback.itemBackground,
      itemForeground:
          itemForeground?.merge(fallback.itemForeground) ??
          fallback.itemForeground,
      separatorColor: separatorColor ?? fallback.separatorColor,
      separatorThickness: separatorThickness ?? fallback.separatorThickness,
      groupBackground: groupBackground ?? fallback.groupBackground,
      groupBorderRadius: groupBorderRadius ?? fallback.groupBorderRadius,
      groupPadding: groupPadding ?? fallback.groupPadding,
      shadows: shadows ?? fallback.shadows,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
    );
  }

  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static ToolbarStyle lerp(ToolbarStyle a, ToolbarStyle b, double t) {
    return ToolbarStyle(
      background: t < 0.5 ? a.background : b.background,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      gap: lerpDouble(a.gap, b.gap, t),
      itemSize: lerpDouble(a.itemSize, b.itemSize, t),
      itemPadding: EdgeInsetsGeometry.lerp(a.itemPadding, b.itemPadding, t),
      iconSize: lerpDouble(a.iconSize, b.iconSize, t),
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      itemBackground: t < 0.5 ? a.itemBackground : b.itemBackground,
      itemForeground: t < 0.5 ? a.itemForeground : b.itemForeground,
      separatorColor: t < 0.5 ? a.separatorColor : b.separatorColor,
      separatorThickness: lerpDouble(
        a.separatorThickness,
        b.separatorThickness,
        t,
      ),
      groupBackground: t < 0.5 ? a.groupBackground : b.groupBackground,
      groupBorderRadius: BorderRadiusGeometry.lerp(
        a.groupBackground == null ? null : a.groupBorderRadius,
        b.groupBackground == null ? null : b.groupBorderRadius,
        t,
      ),
      groupPadding: EdgeInsetsGeometry.lerp(a.groupPadding, b.groupPadding, t),
      shadows: t < 0.5 ? a.shadows : b.shadows,
      surfaceOpacity: lerpDouble(a.surfaceOpacity, b.surfaceOpacity, t),
      surfaceBlur: lerpDouble(a.surfaceBlur, b.surfaceBlur, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ToolbarStyle &&
        other.background == background &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.gap == gap &&
        other.itemSize == itemSize &&
        other.itemPadding == itemPadding &&
        other.iconSize == iconSize &&
        other.textStyle == textStyle &&
        other.itemBackground == itemBackground &&
        other.itemForeground == itemForeground &&
        other.separatorColor == separatorColor &&
        other.separatorThickness == separatorThickness &&
        other.groupBackground == groupBackground &&
        other.groupBorderRadius == groupBorderRadius &&
        other.groupPadding == groupPadding &&
        other.shadows == shadows &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode => Object.hash(
    background,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    gap,
    itemSize,
    itemPadding,
    iconSize,
    textStyle,
    itemBackground,
    itemForeground,
    separatorColor,
    separatorThickness,
    groupBackground,
    groupBorderRadius,
    groupPadding,
    shadows,
    surfaceOpacity,
    surfaceBlur,
  );
}
