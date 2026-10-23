// Registry-owned theme data for the `search_bar` component: the
// [SearchBarTheme] container with the surface, field, item and highlight
// fields plus the token-derived `searchBarDefaults`.
//
// User-owned overrides live in `search_bar_theme.dart`; CLI updates may
// replace this file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';

/// Theme container for the search bar.
class SearchBarTheme extends ComponentThemeData
    implements Mergeable<SearchBarTheme> {
  /// Creates a search bar theme.
  const SearchBarTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.background,
    this.foreground,
    this.mutedForeground,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.itemHighlight,
    this.itemHighlightForeground,
    this.itemPadding,
    this.highlightColor,
    this.textStyle,
    this.shadows,
    this.maxHeight,
    this.minRowHeight,
    this.showLeading,
    this.showClear,
    this.iconSize,
  });

  /// Surface fill of the field + results card.
  final ThemedColor? background;

  /// Item title colour.
  final ThemedColor? foreground;

  /// Group header, empty-state and hint colour.
  final ThemedColor? mutedForeground;

  /// Surface border colour; null draws no border.
  final ThemedColor? borderColor;

  /// Surface border width.
  final double? borderWidth;

  /// Surface corner radius; null falls back to `theme.borderRadiusLg`.
  final BorderRadiusGeometry? borderRadius;

  /// Padding around the result list: the cmdk command surface's `p-1` (4)
  /// as density multipliers, resolved against
  /// `density.baseContentPadding * scaling`.
  final EdgeInsetsGeometry? padding;

  /// Background of the highlighted (keyboard/tap-armed) row.
  final StateValue<ThemedColor>? itemHighlight;

  /// Text/icon colour while a row is highlighted.
  final StateValue<ThemedColor>? itemHighlightForeground;

  /// Padding inside one result row: upstream `px-2 py-1.5` (8/6) as density
  /// multipliers.
  final EdgeInsetsGeometry? itemPadding;

  /// Colour of the matched characters inside a row; null falls back to the
  /// `primary` token.
  final ThemedColor? highlightColor;

  /// Row text style override; null resolves `theme.typography.small`.
  final TextStyle? textStyle;

  /// Surface shadows; empty draws none.
  final List<BoxShadow>? shadows;

  /// Result list height cap; null falls back to 300.
  final double? maxHeight;

  /// Minimum row height so every row meets the touch minimum; null is 48.
  final double? minRowHeight;

  /// Whether the leading search icon shows; null keeps it visible.
  final bool? showLeading;

  /// Whether the trailing clear button shows while text is not empty.
  final bool? showClear;

  /// Leading icon size; null falls back to the density icon token.
  final double? iconSize;

  /// Returns a copy with the given fields replaced.
  SearchBarTheme copyWith({
    ValueGetter<ThemedColor?>? background,
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? mutedForeground,
    ValueGetter<ThemedColor?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<StateValue<ThemedColor>?>? itemHighlight,
    ValueGetter<StateValue<ThemedColor>?>? itemHighlightForeground,
    ValueGetter<EdgeInsetsGeometry?>? itemPadding,
    ValueGetter<ThemedColor?>? highlightColor,
    ValueGetter<TextStyle?>? textStyle,
    ValueGetter<List<BoxShadow>?>? shadows,
    ValueGetter<double?>? maxHeight,
    ValueGetter<double?>? minRowHeight,
    ValueGetter<bool?>? showLeading,
    ValueGetter<bool?>? showClear,
    ValueGetter<double?>? iconSize,
  }) {
    return SearchBarTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      background: background == null ? this.background : background(),
      foreground: foreground == null ? this.foreground : foreground(),
      mutedForeground: mutedForeground == null
          ? this.mutedForeground
          : mutedForeground(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      itemHighlight: itemHighlight == null
          ? this.itemHighlight
          : itemHighlight(),
      itemHighlightForeground: itemHighlightForeground == null
          ? this.itemHighlightForeground
          : itemHighlightForeground(),
      itemPadding: itemPadding == null ? this.itemPadding : itemPadding(),
      highlightColor: highlightColor == null
          ? this.highlightColor
          : highlightColor(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      shadows: shadows == null ? this.shadows : shadows(),
      maxHeight: maxHeight == null ? this.maxHeight : maxHeight(),
      minRowHeight: minRowHeight == null ? this.minRowHeight : minRowHeight(),
      showLeading: showLeading == null ? this.showLeading : showLeading(),
      showClear: showClear == null ? this.showClear : showClear(),
      iconSize: iconSize == null ? this.iconSize : iconSize(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SearchBarTheme merge(SearchBarTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return SearchBarTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      background: background ?? fallback.background,
      foreground: foreground ?? fallback.foreground,
      mutedForeground: mutedForeground ?? fallback.mutedForeground,
      borderColor: borderColor ?? fallback.borderColor,
      borderWidth: borderWidth ?? fallback.borderWidth,
      borderRadius: borderRadius ?? fallback.borderRadius,
      padding: padding ?? fallback.padding,
      itemHighlight:
          itemHighlight?.merge(fallback.itemHighlight) ??
          fallback.itemHighlight,
      itemHighlightForeground:
          itemHighlightForeground?.merge(fallback.itemHighlightForeground) ??
          fallback.itemHighlightForeground,
      itemPadding: itemPadding ?? fallback.itemPadding,
      highlightColor: highlightColor ?? fallback.highlightColor,
      textStyle: textStyle ?? fallback.textStyle,
      shadows: shadows ?? fallback.shadows,
      maxHeight: maxHeight ?? fallback.maxHeight,
      minRowHeight: minRowHeight ?? fallback.minRowHeight,
      showLeading: showLeading ?? fallback.showLeading,
      showClear: showClear ?? fallback.showClear,
      iconSize: iconSize ?? fallback.iconSize,
    );
  }

  /// Lerps scalar fields; token references and lists step at t < 0.5.
  static SearchBarTheme lerp(SearchBarTheme a, SearchBarTheme b, double t) {
    return SearchBarTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      background: t < 0.5 ? a.background : b.background,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      mutedForeground: t < 0.5 ? a.mutedForeground : b.mutedForeground,
      borderColor: t < 0.5 ? a.borderColor : b.borderColor,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t),
      borderRadius: BorderRadiusGeometry.lerp(
        a.borderRadius,
        b.borderRadius,
        t,
      ),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t),
      itemHighlight: t < 0.5 ? a.itemHighlight : b.itemHighlight,
      itemHighlightForeground: t < 0.5
          ? a.itemHighlightForeground
          : b.itemHighlightForeground,
      itemPadding: EdgeInsetsGeometry.lerp(a.itemPadding, b.itemPadding, t),
      highlightColor: t < 0.5 ? a.highlightColor : b.highlightColor,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t),
      shadows: t < 0.5 ? a.shadows : b.shadows,
      maxHeight: lerpDouble(a.maxHeight, b.maxHeight, t),
      minRowHeight: lerpDouble(a.minRowHeight, b.minRowHeight, t),
      showLeading: t < 0.5 ? a.showLeading : b.showLeading,
      showClear: t < 0.5 ? a.showClear : b.showClear,
      iconSize: lerpDouble(a.iconSize, b.iconSize, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SearchBarTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.background == background &&
        other.foreground == foreground &&
        other.mutedForeground == mutedForeground &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.itemHighlight == itemHighlight &&
        other.itemHighlightForeground == itemHighlightForeground &&
        other.itemPadding == itemPadding &&
        other.highlightColor == highlightColor &&
        other.textStyle == textStyle &&
        _sameShadows(other.shadows, shadows) &&
        other.maxHeight == maxHeight &&
        other.minRowHeight == minRowHeight &&
        other.showLeading == showLeading &&
        other.showClear == showClear &&
        other.iconSize == iconSize;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    background,
    foreground,
    mutedForeground,
    borderColor,
    borderWidth,
    borderRadius,
    padding,
    itemHighlight,
    itemHighlightForeground,
    itemPadding,
    highlightColor,
    textStyle,
    shadows == null ? null : Object.hashAll(shadows!),
    maxHeight,
    minRowHeight,
    showLeading,
    showClear,
    iconSize,
  ]);

  static bool _sameShadows(List<BoxShadow>? a, List<BoxShadow>? b) {
    if (identical(a, b)) {
      return true;
    }
    if (a == null || b == null || a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i += 1) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }
}

/// Default item padding: upstream `px-2 py-1.5` as density multipliers.
const EdgeInsetsGeometry searchBarDefaultItemPadding =
    EdgeInsetsDensity.pxSymmetric(horizontal: 8, vertical: 6);

const StateValue<ThemedColor> _searchItemBg = StateValue(
  hovered: ThemedColor.ref(ColorRef.accent),
  pressed: ThemedColor.ref(ColorRef.accent),
  selected: ThemedColor.ref(ColorRef.accent),
);

const StateValue<ThemedColor> _searchItemFg = StateValue(
  hovered: ThemedColor.ref(ColorRef.accentForeground),
  pressed: ThemedColor.ref(ColorRef.accentForeground),
  selected: ThemedColor.ref(ColorRef.accentForeground),
);

/// Token-derived baseline; every unset override field falls through here.
const SearchBarTheme searchBarDefaults = SearchBarTheme(
  background: ThemedColor.ref(ColorRef.popover),
  foreground: ThemedColor.ref(ColorRef.foreground),
  mutedForeground: ThemedColor.ref(ColorRef.mutedForeground),
  borderColor: ThemedColor.ref(ColorRef.border),
  borderWidth: 1,
  padding: EdgeInsetsDensity.pxAll(4),
  itemHighlight: _searchItemBg,
  itemHighlightForeground: _searchItemFg,
  itemPadding: searchBarDefaultItemPadding,
  highlightColor: ThemedColor.ref(ColorRef.primary),
  maxHeight: 300,
  minRowHeight: 48,
  showLeading: true,
  showClear: true,
);

/// Default leading-icon size.
const double searchBarDefaultIconSize = 16;
