import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

typedef ActionSheetStyle = ActionSheetTheme;

class ActionSheetTheme extends ComponentThemeData
    implements Mergeable<ActionSheetTheme> {
  const ActionSheetTheme({
    super.themeDensity,
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

  @override
  ActionSheetTheme merge(ActionSheetTheme? fallback) {
    if (fallback == null) return this;
    return ActionSheetTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
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
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ActionSheetTheme &&
        other.themeDensity == themeDensity &&
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
        other.maxWidth == maxWidth;
  }

  @override
  int get hashCode => Object.hashAll([
    themeDensity,
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
  ]);
}

const ActionSheetTheme actionSheetDefaults = ActionSheetTheme();
