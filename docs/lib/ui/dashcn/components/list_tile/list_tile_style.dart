// Registry-owned theme data for the `list_tile` component: the
// [ListTileTheme] container (also aliased as [ListTileStyle] for per-instance
// overrides) and the token-derived [listTileDefaults].
//
// User-owned overrides live in `list_tile_theme.dart`.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Per-instance style alias for [ListTileTheme].
typedef ListTileStyle = ListTileTheme;

/// Styling of a list tile.
class ListTileTheme extends ComponentThemeData
    implements Mergeable<ListTileTheme> {
  const ListTileTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.padding,
    this.titleStyle,
    this.subtitleStyle,
    this.leadingWidth,
    this.minLeadingWidth,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.selectedColor,
    this.tileColor,
    this.iconColor,
    this.textColor,
    this.subtitleColor,
    this.dividerColor,
    this.shape,
    this.dense,
    this.enableFeedback,
  });

  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? leadingWidth;
  final double? minLeadingWidth;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final ThemedColor? selectedColor;
  final ThemedColor? tileColor;
  final ThemedColor? iconColor;
  final ThemedColor? textColor;
  final ThemedColor? subtitleColor;
  final ThemedColor? dividerColor;
  final ShapeBorder? shape;
  final bool? dense;
  final bool? enableFeedback;

  ListTileTheme copyWith({
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    double? leadingWidth,
    double? minLeadingWidth,
    double? horizontalTitleGap,
    double? minVerticalPadding,
    ThemedColor? selectedColor,
    ThemedColor? tileColor,
    ThemedColor? iconColor,
    ThemedColor? textColor,
    ThemedColor? subtitleColor,
    ThemedColor? dividerColor,
    ShapeBorder? shape,
    bool? dense,
    bool? enableFeedback,
  }) {
    return ListTileTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      minLeadingWidth: minLeadingWidth ?? this.minLeadingWidth,
      horizontalTitleGap: horizontalTitleGap ?? this.horizontalTitleGap,
      minVerticalPadding: minVerticalPadding ?? this.minVerticalPadding,
      selectedColor: selectedColor ?? this.selectedColor,
      tileColor: tileColor ?? this.tileColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      dividerColor: dividerColor ?? this.dividerColor,
      shape: shape ?? this.shape,
      dense: dense ?? this.dense,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  @override
  ListTileTheme merge(ListTileTheme? fallback) {
    if (fallback == null) return this;
    return ListTileTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      padding: padding ?? fallback.padding,
      titleStyle: titleStyle == null
          ? fallback.titleStyle
          : (fallback.titleStyle?.merge(titleStyle) ?? titleStyle),
      subtitleStyle: subtitleStyle == null
          ? fallback.subtitleStyle
          : (fallback.subtitleStyle?.merge(subtitleStyle) ?? subtitleStyle),
      leadingWidth: leadingWidth ?? fallback.leadingWidth,
      minLeadingWidth: minLeadingWidth ?? fallback.minLeadingWidth,
      horizontalTitleGap: horizontalTitleGap ?? fallback.horizontalTitleGap,
      minVerticalPadding: minVerticalPadding ?? fallback.minVerticalPadding,
      selectedColor: selectedColor ?? fallback.selectedColor,
      tileColor: tileColor ?? fallback.tileColor,
      iconColor: iconColor ?? fallback.iconColor,
      textColor: textColor ?? fallback.textColor,
      subtitleColor: subtitleColor ?? fallback.subtitleColor,
      dividerColor: dividerColor ?? fallback.dividerColor,
      shape: shape ?? fallback.shape,
      dense: dense ?? fallback.dense,
      enableFeedback: enableFeedback ?? fallback.enableFeedback,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ListTileTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.padding == padding &&
        other.titleStyle == titleStyle &&
        other.subtitleStyle == subtitleStyle &&
        other.leadingWidth == leadingWidth &&
        other.minLeadingWidth == minLeadingWidth &&
        other.horizontalTitleGap == horizontalTitleGap &&
        other.minVerticalPadding == minVerticalPadding &&
        other.selectedColor == selectedColor &&
        other.tileColor == tileColor &&
        other.iconColor == iconColor &&
        other.textColor == textColor &&
        other.subtitleColor == subtitleColor &&
        other.dividerColor == dividerColor &&
        other.shape == shape &&
        other.dense == dense &&
        other.enableFeedback == enableFeedback;
  }

  @override
  int get hashCode => Object.hashAll([
    themeDensity,
    themeSpacing,
    themeShadows,
    padding,
    titleStyle,
    subtitleStyle,
    leadingWidth,
    minLeadingWidth,
    horizontalTitleGap,
    minVerticalPadding,
    selectedColor,
    tileColor,
    iconColor,
    textColor,
    subtitleColor,
    dividerColor,
    shape,
    dense,
    enableFeedback,
  ]);
}

const ListTileTheme listTileDefaults = ListTileTheme();
