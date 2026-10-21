import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';

typedef ActionSheetStyle = ActionSheetTheme;

class ActionSheetTheme extends ComponentThemeData
    implements Mergeable<ActionSheetTheme> {
  const ActionSheetTheme({
    super.themeDensity,
    super.themeDensityTokens,
    super.themeSpacing,
    super.themeShadows,
    this.backgroundColor,
    this.titleStyle,
    this.messageStyle,
    this.actionStyle,
    this.destructiveColor,
    this.cancelColor,
    this.dividerColor,
    this.padding,
    this.borderRadius,
    this.maxWidth,
    this.rowMinHeight,
    this.iconSize,
    this.titleSpacing,
    this.messageSpacing,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.transitionDuration,
  });

  final ThemedColor? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final TextStyle? actionStyle;
  final ThemedColor? destructiveColor;
  final ThemedColor? cancelColor;
  final ThemedColor? dividerColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? maxWidth;

  /// Row min-height override; null resolves `DensityTokens.rowMinHeight`
  /// (32 compact / 40 comfortable / 48 touch).
  final double? rowMinHeight;

  /// Icon size override; null resolves `DensityTokens.iconSize`
  /// (16 / 20 / 24).
  final double? iconSize;

  /// Gap between title and message; null resolves `tokens.gap / 2`
  /// (4 compact, from the spacing scale).
  final double? titleSpacing;

  /// Gap between header and actions / cancel; null resolves `tokens.gap`
  /// (8 compact, from the spacing scale).
  final double? messageSpacing;

  /// Frosted-glass opacity applied to the sheet fill; null is opaque.
  final double? surfaceOpacity;

  /// Frosted-glass blur sigma; null draws no blur layer.
  final double? surfaceBlur;

  /// Open/close transition duration; null uses the theme motion slow token.
  /// The sheet route honours reduced motion (snaps when disabled).
  final Duration? transitionDuration;

  ActionSheetTheme copyWith({
    DensityTokens? themeDensityTokens,
    ThemedColor? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? actionStyle,
    ThemedColor? destructiveColor,
    ThemedColor? cancelColor,
    ThemedColor? dividerColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? maxWidth,
    double? rowMinHeight,
    double? iconSize,
    double? titleSpacing,
    double? messageSpacing,
    double? surfaceOpacity,
    double? surfaceBlur,
    Duration? transitionDuration,
  }) {
    return ActionSheetTheme(
      themeDensity: themeDensity,
      themeDensityTokens: themeDensityTokens ?? this.themeDensityTokens,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      actionStyle: actionStyle ?? this.actionStyle,
      destructiveColor: destructiveColor ?? this.destructiveColor,
      cancelColor: cancelColor ?? this.cancelColor,
      dividerColor: dividerColor ?? this.dividerColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      maxWidth: maxWidth ?? this.maxWidth,
      rowMinHeight: rowMinHeight ?? this.rowMinHeight,
      iconSize: iconSize ?? this.iconSize,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      messageSpacing: messageSpacing ?? this.messageSpacing,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      transitionDuration: transitionDuration ?? this.transitionDuration,
    );
  }

  @override
  ActionSheetTheme merge(ActionSheetTheme? fallback) {
    if (fallback == null) return this;
    return ActionSheetTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeDensityTokens: themeDensityTokens ?? fallback.themeDensityTokens,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      backgroundColor: backgroundColor ?? fallback.backgroundColor,
      titleStyle: titleStyle == null
          ? fallback.titleStyle
          : (fallback.titleStyle?.merge(titleStyle) ?? titleStyle),
      messageStyle: messageStyle == null
          ? fallback.messageStyle
          : (fallback.messageStyle?.merge(messageStyle) ?? messageStyle),
      actionStyle: actionStyle == null
          ? fallback.actionStyle
          : (fallback.actionStyle?.merge(actionStyle) ?? actionStyle),
      destructiveColor: destructiveColor ?? fallback.destructiveColor,
      cancelColor: cancelColor ?? fallback.cancelColor,
      dividerColor: dividerColor ?? fallback.dividerColor,
      padding: padding ?? fallback.padding,
      borderRadius: borderRadius ?? fallback.borderRadius,
      maxWidth: maxWidth ?? fallback.maxWidth,
      rowMinHeight: rowMinHeight ?? fallback.rowMinHeight,
      iconSize: iconSize ?? fallback.iconSize,
      titleSpacing: titleSpacing ?? fallback.titleSpacing,
      messageSpacing: messageSpacing ?? fallback.messageSpacing,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
      transitionDuration: transitionDuration ?? fallback.transitionDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActionSheetTheme &&
        other.themeDensity == themeDensity &&
        other.themeDensityTokens == themeDensityTokens &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.backgroundColor == backgroundColor &&
        other.titleStyle == titleStyle &&
        other.messageStyle == messageStyle &&
        other.actionStyle == actionStyle &&
        other.destructiveColor == destructiveColor &&
        other.cancelColor == cancelColor &&
        other.dividerColor == dividerColor &&
        other.padding == padding &&
        other.borderRadius == borderRadius &&
        other.maxWidth == maxWidth &&
        other.rowMinHeight == rowMinHeight &&
        other.iconSize == iconSize &&
        other.titleSpacing == titleSpacing &&
        other.messageSpacing == messageSpacing &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.transitionDuration == transitionDuration;
  }

  @override
  int get hashCode => Object.hashAll([
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
    backgroundColor,
    titleStyle,
    messageStyle,
    actionStyle,
    destructiveColor,
    cancelColor,
    dividerColor,
    padding,
    borderRadius,
    maxWidth,
    rowMinHeight,
    iconSize,
    titleSpacing,
    messageSpacing,
    surfaceOpacity,
    surfaceBlur,
    transitionDuration,
  ]);
}

const ActionSheetTheme actionSheetDefaults = ActionSheetTheme();
