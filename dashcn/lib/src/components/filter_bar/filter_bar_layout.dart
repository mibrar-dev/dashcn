// Layout helpers for the `filter_bar` component.

import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../chip/chip.dart';
import 'filter_bar_style.dart';

export 'filter_bar_inline.dart';

/// Renders active chips with density-scaled spacing and remove buttons.
Widget filterBarChipsRow({
  required BuildContext context,
  required FilterState current,
  required ValueChanged<FilterState> onEmit,
  required DensityTokens tokens,
  FilterBarStyle? style,
  Widget Function(BuildContext, FilterChipData, VoidCallback)? chipBuilder,
}) {
  return Wrap(
    spacing: kSpace2,
    runSpacing: kSpace2,
    children: <Widget>[
      for (final FilterChipData chip in current.chips)
        chipBuilder?.call(
              context,
              chip,
              () => onEmit(current.withoutChip(chip.key)),
            ) ??
            Chip(
              padding: style?.chipPadding,
              trailing: ChipButton(
                onPressed: () => onEmit(current.withoutChip(chip.key)),
                semanticLabel: ComponentLocalizations.of(
                  context,
                ).chipInputRemoveChip,
                child: Icon(
                  LucideIcons.x,
                  size:
                      style?.chipIconSize ??
                      (tokens.iconSize * 0.75).clamp(12.0, 16.0),
                ),
              ),
              child: Text(chip.label, style: style?.chipTextStyle),
            ),
    ],
  );
}

/// Composes the controls (sort, date, custom filters) for menu or sheet display.
Widget filterBarOverflowContent({
  required BuildContext context,
  required FilterState current,
  required ValueChanged<FilterState> onEmit,
  required DensityTokens tokens,
  required List<FilterSortOption> sortOptions,
  required bool enableDateRange,
  required List<FilterCustomFilter> customFilters,
  required List<Widget> trailingFilters,
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
}) {
  final double ctrlW = double.infinity;
  final double? ctrlH = style?.controlHeight ?? theme?.controlHeight;
  final double iconSz = style?.iconSize ?? theme?.iconSize ?? tokens.iconSize;
  final double runSp = style?.runSpacing ?? theme?.runSpacing ?? kSpace2;

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

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < others.length; i++) ...<Widget>[
        if (i > 0) Gap(runSp),
        others[i],
      ],
      for (final FilterCustomFilter filter in customFilters) ...<Widget>[
        Gap(runSp),
        filter.builder(context, current, onEmit),
      ],
    ],
  );
}

/// Composes the compact overflow column for narrow screens.
Widget filterBarOverflowBody({
  required BuildContext context,
  required FilterState current,
  required ValueChanged<FilterState> onEmit,
  required DensityTokens tokens,
  required Widget searchWidget,
  required bool hasOverflowContent,
  required VoidCallback onOpen,
  required double sp,
  required double runSp,
  Widget? leading,
  Widget? trailing,
  FilterBarStyle? style,
  FilterBarTheme? theme,
  Widget Function(BuildContext, int, VoidCallback)? triggerBuilder,
  Widget Function(BuildContext, FilterChipData, VoidCallback)? chipBuilder,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Wrap(
        spacing: sp,
        runSpacing: runSp,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          ?leading,
          searchWidget,
          if (hasOverflowContent)
            Builder(
              builder: (BuildContext btnContext) {
                return triggerBuilder?.call(
                      btnContext,
                      current.activeFilterCount,
                      onOpen,
                    ) ??
                    FilterBarSheetTrigger(
                      activeCount: current.activeFilterCount,
                      onPressed: onOpen,
                      dense: style?.dense ?? theme?.dense ?? false,
                      iconSize: style?.iconSize ?? theme?.iconSize,
                      densityTokens: tokens,
                    );
              },
            ),
          ?trailing,
        ],
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
