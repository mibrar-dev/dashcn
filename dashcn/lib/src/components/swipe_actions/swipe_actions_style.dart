// Registry-owned theme data for the `swipe_actions` component.
//
// User-owned overrides live in `swipe_actions_theme.dart`; CLI updates may
// replace this file.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';

/// Per-instance style alias for [SwipeActionsTheme].
typedef SwipeActionsStyle = SwipeActionsTheme;

/// Styling of a swipeable row's trailing actions.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. Sizes resolve from the
/// density tokens when null, so an empty override keeps the token look:
/// tile at least 64 px wide (readable labels), icon 16, label 13.
class SwipeActionsTheme extends ComponentThemeData
    implements Mergeable<SwipeActionsTheme> {
  const SwipeActionsTheme({
    super.themeDensity,
    super.themeDensityTokens,
    super.themeSpacing,
    super.themeShadows,
    this.actionWidth,
    this.iconSize,
    this.labelStyle,
    this.iconLabelGap,
    this.rowMinHeight,
  });

  /// Width of one action tile; null resolves at least 64 px
  /// (`max(tokens.controlHeight + 24, 64)`: 64 compact / 64 comfortable /
  /// 72 touch) so labels stay readable.
  final double? actionWidth;

  /// Icon size in the default tile; null resolves `tokens.iconSize`
  /// (16 / 20 / 24).
  final double? iconSize;

  /// Label style in the default tile; null resolves
  /// `TextStyle(fontSize: tokens.subtitleTextSize)` (13 compact, readable).
  final TextStyle? labelStyle;

  /// Gap between icon and label; null resolves `tokens.gap / 2`
  /// (4 compact, from the spacing scale).
  final double? iconLabelGap;

  /// Row min-height; null resolves `tokens.rowMinHeight`
  /// (32 compact / 40 comfortable / 48 touch).
  final double? rowMinHeight;

  SwipeActionsTheme copyWith({
    DensityTokens? themeDensityTokens,
    double? actionWidth,
    double? iconSize,
    TextStyle? labelStyle,
    double? iconLabelGap,
    double? rowMinHeight,
  }) {
    return SwipeActionsTheme(
      themeDensity: themeDensity,
      themeDensityTokens: themeDensityTokens ?? this.themeDensityTokens,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      actionWidth: actionWidth ?? this.actionWidth,
      iconSize: iconSize ?? this.iconSize,
      labelStyle: labelStyle ?? this.labelStyle,
      iconLabelGap: iconLabelGap ?? this.iconLabelGap,
      rowMinHeight: rowMinHeight ?? this.rowMinHeight,
    );
  }

  @override
  SwipeActionsTheme merge(SwipeActionsTheme? fallback) {
    if (fallback == null) return this;
    return SwipeActionsTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeDensityTokens: themeDensityTokens ?? fallback.themeDensityTokens,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      actionWidth: actionWidth ?? fallback.actionWidth,
      iconSize: iconSize ?? fallback.iconSize,
      labelStyle: labelStyle == null
          ? fallback.labelStyle
          : (fallback.labelStyle?.merge(labelStyle) ?? labelStyle),
      iconLabelGap: iconLabelGap ?? fallback.iconLabelGap,
      rowMinHeight: rowMinHeight ?? fallback.rowMinHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwipeActionsTheme &&
        other.themeDensity == themeDensity &&
        other.themeDensityTokens == themeDensityTokens &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.actionWidth == actionWidth &&
        other.iconSize == iconSize &&
        other.labelStyle == labelStyle &&
        other.iconLabelGap == iconLabelGap &&
        other.rowMinHeight == rowMinHeight;
  }

  @override
  int get hashCode => Object.hashAll([
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
    actionWidth,
    iconSize,
    labelStyle,
    iconLabelGap,
    rowMinHeight,
  ]);
}

const SwipeActionsTheme swipeActionsDefaults = SwipeActionsTheme();

/// Tile width from [tokens]: at least 64 px (the comfortable token width)
/// and full row height. Compact `control + 24` (56) is bumped to the 64
/// minimum so labels stay readable; comfortable (64) and touch (72) keep
/// their token widths. Never below the 48 px touch minimum.
double swipeActionWidthForTokens(DensityTokens tokens) {
  final double width = tokens.controlHeight + 24;
  final double withFloor = width < 64 ? 64 : width;
  return withFloor < 48 ? 48 : withFloor;
}
