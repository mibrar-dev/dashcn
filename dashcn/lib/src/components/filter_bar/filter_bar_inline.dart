// Desktop and wide-screen inline layout for `filter_bar`.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'filter_bar_layout.dart';
import 'filter_bar_style.dart';

/// Composes the inline layout for desktop and wide screens.
Widget filterBarInlineLayout({
  required BuildContext context,
  required FilterState current,
  required ValueChanged<FilterState> onEmit,
  required VoidCallback onClearAll,
  required DensityTokens tokens,
  required Widget searchWidget,
  required List<FilterSortOption> sortOptions,
  required bool enableDateRange,
  required List<FilterCustomFilter> customFilters,
  required List<FilterGroup> groups,
  required List<Widget> trailingFilters,
  required bool showClearAllWhenEmpty,
  required double sp,
  required double runSp,
  int? resultsCount,
  Widget? leading,
  Widget? trailing,
  FilterBarStyle? style,
  FilterBarTheme? theme,
  Widget Function(
    BuildContext,
    String?,
    List<FilterSortOption>,
    ValueChanged<String?>,
  )?
  sortBuilder,
  Widget Function(
    BuildContext,
    FilterDateRange?,
    ValueChanged<FilterDateRange?>,
  )?
  dateBuilder,
  Widget Function(BuildContext, bool, VoidCallback)? clearAllBuilder,
  Widget Function(BuildContext, FilterChipData, VoidCallback)? chipBuilder,
  Widget Function(BuildContext, int?, int)? counterBuilder,
}) {
  final ThemeData ambient = Theme.of(context);
  final ComponentLocalizations l10n = ComponentLocalizations.of(context);
  final double ctrlW = style?.controlWidth ?? theme?.controlWidth ?? 180;
  final double? ctrlH = style?.controlHeight ?? theme?.controlHeight;
  final double iconSz = style?.iconSize ?? theme?.iconSize ?? tokens.iconSize;

  final String? sortValue =
      sortOptions.any((FilterSortOption o) => o.id == current.sortId)
      ? current.sortId
      : null;

  final Widget sortWidget =
      sortBuilder?.call(
        context,
        sortValue,
        sortOptions,
        (String? next) => onEmit(current.copyWith(sortId: next)),
      ) ??
      FilterBarSortControl(
        value: sortValue,
        options: sortOptions,
        onChanged: (String? next) => onEmit(current.copyWith(sortId: next)),
        width: ctrlW,
        height: ctrlH,
        iconSize: iconSz,
        textStyle: style?.textStyle,
        densityTokens: tokens,
      );

  final Widget dateWidget =
      dateBuilder?.call(
        context,
        current.dateRange,
        (FilterDateRange? next) => onEmit(current.copyWith(dateRange: next)),
      ) ??
      FilterBarDateControl(
        value: current.dateRange,
        onChanged: (FilterDateRange? next) =>
            onEmit(current.copyWith(dateRange: next)),
        width: ctrlW,
        height: ctrlH,
        densityTokens: tokens,
      );

  final List<Widget> others = <Widget>[
    if (sortOptions.isNotEmpty) sortWidget,
    if (enableDateRange) dateWidget,
    ...trailingFilters,
  ];

  final Widget controls = FilterBarGroupedContent(
    state: current,
    onChanged: onEmit,
    groups: groups,
    customFilters: customFilters,
    trailing: others,
    spacing: sp,
    runSpacing: runSp,
  );

  final List<Widget> slots = <Widget>[
    ?leading,
    searchWidget,
    if (groups.isEmpty)
      controls
    else
      SizedBox(width: double.infinity, child: controls),
    ?trailing,
  ];

  final String? counter = _formatCounter(current, resultsCount, l10n);
  if (counter != null) {
    slots.add(
      counterBuilder?.call(context, resultsCount, current.activeFilterCount) ??
          Text(
            counter,
            style:
                style?.mutedTextStyle ??
                ambient.typography.textMuted.copyWith(
                  color: ambient.colors.mutedForeground,
                  fontSize: tokens.subtitleTextSize,
                ),
          ),
    );
  }

  if (showClearAllWhenEmpty || current.hasActiveFilters) {
    slots.add(
      clearAllBuilder?.call(context, current.hasActiveFilters, onClearAll) ??
          FilterBarClearButton(
            enabled: current.hasActiveFilters,
            onPressed: onClearAll,
            dense: style?.dense ?? theme?.dense ?? false,
            iconSize: iconSz,
            densityTokens: tokens,
          ),
    );
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Wrap(
        spacing: sp,
        runSpacing: runSp,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: slots,
      ),
      if (current.chips.isNotEmpty) ...<Widget>[
        Gap(runSp),
        filterBarChipsRow(
          context: context,
          current: current,
          onEmit: onEmit,
          tokens: tokens,
          style: style,
          chipBuilder: chipBuilder,
        ),
      ],
    ],
  );
}

String? _formatCounter(
  FilterState current,
  int? resultsCount,
  ComponentLocalizations l10n,
) {
  if (resultsCount != null) {
    return l10n.filterResultsCount(resultsCount);
  }
  final int count = current.activeFilterCount;
  return count == 0 ? null : l10n.filterActiveCount(count);
}
