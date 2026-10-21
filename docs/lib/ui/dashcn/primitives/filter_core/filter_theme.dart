// The theme data of the `filter_bar` engine: [FilterBarTheme] and its
// token-derived `filterBarDefaults`.
//
// Lives next to the engine in `primitives/filter_core/` because the flat
// component folder is capped at two code files and `filter_bar_style.dart`
// already carries the descriptors, sheet chrome and control sub-widgets (the
// primitives layer defines other component themes too: `HoverTheme`,
// `BasicTheme`, `FileUploadRowTheme`). Re-exported by the component.

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Theme data for the `filter_bar` component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class FilterBarTheme extends ComponentThemeData
    implements Mergeable<FilterBarTheme> {
  /// Creates a filter bar theme.
  const FilterBarTheme({
    super.themeDensity,
    super.themeDensityTokens,
    super.themeSpacing,
    super.themeShadows,
    this.spacing,
    this.runSpacing,
    this.searchWidth,
    this.controlWidth,
    this.controlHeight,
    this.iconSize,
    this.dense,
  });

  /// Gap between controls on the same run.
  final double? spacing;

  /// Gap between wrapped runs.
  final double? runSpacing;

  /// Width of the search field.
  final double? searchWidth;

  /// Width of the sort and date controls.
  final double? controlWidth;

  /// Height of the controls (search, sort, date).
  final double? controlHeight;

  /// Icon size across filter controls.
  final double? iconSize;

  /// Compact paddings and small buttons.
  final bool? dense;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  FilterBarTheme merge(FilterBarTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return FilterBarTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeDensityTokens: themeDensityTokens ?? fallback.themeDensityTokens,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      spacing: spacing ?? fallback.spacing,
      runSpacing: runSpacing ?? fallback.runSpacing,
      searchWidth: searchWidth ?? fallback.searchWidth,
      controlWidth: controlWidth ?? fallback.controlWidth,
      controlHeight: controlHeight ?? fallback.controlHeight,
      iconSize: iconSize ?? fallback.iconSize,
      dense: dense ?? fallback.dense,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FilterBarTheme &&
        other.themeDensity == themeDensity &&
        other.themeDensityTokens == themeDensityTokens &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.spacing == spacing &&
        other.runSpacing == runSpacing &&
        other.searchWidth == searchWidth &&
        other.controlWidth == controlWidth &&
        other.controlHeight == controlHeight &&
        other.iconSize == iconSize &&
        other.dense == dense;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
    spacing,
    runSpacing,
    searchWidth,
    controlWidth,
    controlHeight,
    iconSize,
    dense,
  );
}

/// Token-derived defaults: 8px spacing, 8px run spacing, 220px search,
/// 180px sort/date controls, compact density.
const FilterBarTheme filterBarDefaults = FilterBarTheme(
  spacing: 8,
  runSpacing: 8,
  searchWidth: 220,
  controlWidth: 180,
  iconSize: 16,
  dense: false,
);
