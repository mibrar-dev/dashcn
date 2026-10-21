// Visual styling and configuration for the `filter_bar` component.
//
// Defines [FilterBarStyle] for per-instance token overrides, the
// [FilterBarPresentation] enum, and re-exports the primitives theme data
// ([FilterBarTheme], [filterBarDefaults]).

import 'package:flutter/widgets.dart';

import '../../primitives/filter_core/filter_state.dart';

export '../../primitives/filter_core/filter_group.dart';
export '../../primitives/filter_core/filter_theme.dart';
export 'filter_bar_controls.dart';
export 'filter_bar_overflow.dart';

/// How a `FilterBar` presents its controls.
enum FilterBarPresentation {
  /// All controls inline within the bar.
  inline,

  /// Controls presented in a drawer sheet.
  sheet,

  /// Responsive: sheet presentation below [FilterBar.sheetBreakpoint].
  autoSheet,

  /// Controls overflow into an anchored compact menu.
  menu,

  /// Responsive: compact menu overflow below [FilterBar.sheetBreakpoint].
  autoMenu,
}

/// Resolves the next state when "clear all" runs.
typedef FilterBarClearResolver = FilterState Function(FilterState current);

/// Per-instance style overrides for every visual token of [FilterBar].
class FilterBarStyle {
  /// Creates a filter bar style.
  const FilterBarStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.spacing,
    this.runSpacing,
    this.searchWidth,
    this.controlWidth,
    this.controlHeight,
    this.iconSize,
    this.textStyle,
    this.mutedTextStyle,
    this.chipPadding,
    this.chipTextStyle,
    this.chipIconSize,
    this.elevation,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.dense,
    this.overflowMenuWidth,
  });

  /// Background color of the filter bar container.
  final Color? backgroundColor;

  /// Border color of the filter bar container.
  final Color? borderColor;

  /// Border radius of the filter bar container.
  final BorderRadiusGeometry? borderRadius;

  /// Inset padding inside the filter bar container.
  final EdgeInsetsGeometry? padding;

  /// Gap between controls on the same run.
  final double? spacing;

  /// Gap between wrapped runs.
  final double? runSpacing;

  /// Fixed width of the search field.
  final double? searchWidth;

  /// Fixed width of the sort and date controls.
  final double? controlWidth;

  /// Height of the controls (search, sort, date).
  final double? controlHeight;

  /// Icon size across filter controls.
  final double? iconSize;

  /// Main typography for labels and inputs.
  final TextStyle? textStyle;

  /// Typography for counters and secondary text.
  final TextStyle? mutedTextStyle;

  /// Padding for active filter chips.
  final EdgeInsetsGeometry? chipPadding;

  /// Typography for active filter chip labels.
  final TextStyle? chipTextStyle;

  /// Icon size for the chip remove button.
  final double? chipIconSize;

  /// Elevation / box shadows.
  final List<BoxShadow>? elevation;

  /// Surface fill opacity for floating surfaces (menu/sheet).
  final double? surfaceOpacity;

  /// Frosted-glass backdrop blur sigma.
  final double? surfaceBlur;

  /// Compact paddings and small buttons.
  final bool? dense;

  /// Width of the compact overflow menu.
  final double? overflowMenuWidth;

  /// Creates a copy with the given fields replaced.
  FilterBarStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    double? spacing,
    double? runSpacing,
    double? searchWidth,
    double? controlWidth,
    double? controlHeight,
    double? iconSize,
    TextStyle? textStyle,
    TextStyle? mutedTextStyle,
    EdgeInsetsGeometry? chipPadding,
    TextStyle? chipTextStyle,
    double? chipIconSize,
    List<BoxShadow>? elevation,
    double? surfaceOpacity,
    double? surfaceBlur,
    bool? dense,
    double? overflowMenuWidth,
  }) {
    return FilterBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      spacing: spacing ?? this.spacing,
      runSpacing: runSpacing ?? this.runSpacing,
      searchWidth: searchWidth ?? this.searchWidth,
      controlWidth: controlWidth ?? this.controlWidth,
      controlHeight: controlHeight ?? this.controlHeight,
      iconSize: iconSize ?? this.iconSize,
      textStyle: textStyle ?? this.textStyle,
      mutedTextStyle: mutedTextStyle ?? this.mutedTextStyle,
      chipPadding: chipPadding ?? this.chipPadding,
      chipTextStyle: chipTextStyle ?? this.chipTextStyle,
      chipIconSize: chipIconSize ?? this.chipIconSize,
      elevation: elevation ?? this.elevation,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      dense: dense ?? this.dense,
      overflowMenuWidth: overflowMenuWidth ?? this.overflowMenuWidth,
    );
  }

  /// Merges this style with [other]; fields in this style win over [other].
  FilterBarStyle merge(FilterBarStyle? other) {
    if (other == null) return this;
    return FilterBarStyle(
      backgroundColor: backgroundColor ?? other.backgroundColor,
      borderColor: borderColor ?? other.borderColor,
      borderRadius: borderRadius ?? other.borderRadius,
      padding: padding ?? other.padding,
      spacing: spacing ?? other.spacing,
      runSpacing: runSpacing ?? other.runSpacing,
      searchWidth: searchWidth ?? other.searchWidth,
      controlWidth: controlWidth ?? other.controlWidth,
      controlHeight: controlHeight ?? other.controlHeight,
      iconSize: iconSize ?? other.iconSize,
      textStyle: textStyle ?? other.textStyle,
      mutedTextStyle: mutedTextStyle ?? other.mutedTextStyle,
      chipPadding: chipPadding ?? other.chipPadding,
      chipTextStyle: chipTextStyle ?? other.chipTextStyle,
      chipIconSize: chipIconSize ?? other.chipIconSize,
      elevation: elevation ?? other.elevation,
      surfaceOpacity: surfaceOpacity ?? other.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? other.surfaceBlur,
      dense: dense ?? other.dense,
      overflowMenuWidth: overflowMenuWidth ?? other.overflowMenuWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterBarStyle &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.spacing == spacing &&
        other.runSpacing == runSpacing &&
        other.searchWidth == searchWidth &&
        other.controlWidth == controlWidth &&
        other.controlHeight == controlHeight &&
        other.iconSize == iconSize &&
        other.textStyle == textStyle &&
        other.mutedTextStyle == mutedTextStyle &&
        other.chipPadding == chipPadding &&
        other.chipTextStyle == chipTextStyle &&
        other.chipIconSize == chipIconSize &&
        other.elevation == elevation &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.dense == dense &&
        other.overflowMenuWidth == overflowMenuWidth;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    backgroundColor,
    borderColor,
    borderRadius,
    padding,
    spacing,
    runSpacing,
    searchWidth,
    controlWidth,
    controlHeight,
    iconSize,
    textStyle,
    mutedTextStyle,
    chipPadding,
    chipTextStyle,
    chipIconSize,
    elevation,
    surfaceOpacity,
    surfaceBlur,
    dense,
    overflowMenuWidth,
  ]);
}
