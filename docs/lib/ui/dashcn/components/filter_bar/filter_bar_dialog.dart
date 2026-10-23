// Centred dialog presentation for `filter_bar`.

import 'package:flutter/widgets.dart';

import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../dialog/dialog.dart';
import 'filter_bar_layout.dart';
import 'filter_bar_style.dart';

/// Opens the centred filter dialog for [FilterBar].
///
/// The dialog card follows the density sizing (control heights, 16 px icons,
/// 8 px gaps) and the same theme tokens as the inline bar and the anchored
/// popup menu: the card fill, border, radius and `shadowLg` match
/// [FilterBarSheetScaffold], constrained to the compact overlay max width.
Future<void> openFilterBarDialog({
  required BuildContext context,
  required ValueNotifier<FilterState> stateMirror,
  required DensityTokens tokens,
  required FilterBarTheme theme,
  required ValueChanged<FilterState> onEmit,
  required List<FilterSortOption> sortOptions,
  required bool enableDateRange,
  required List<FilterCustomFilter> customFilters,
  required List<Widget> trailingFilters,
  required bool showClearAllWhenEmpty,
  FilterBarStyle? style,
  int? resultsCount,
  VoidCallback? onClearAll,
  EdgeInsetsGeometry? contentPadding,
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
  Widget Function(BuildContext, FilterState, VoidCallback)? dialogBuilder,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return ValueListenableBuilder<FilterState>(
        valueListenable: stateMirror,
        builder: (BuildContext ctx, FilterState current, _) {
          final ComponentLocalizations l10n = ComponentLocalizations.of(
            dialogContext,
          );
          final ThemeData ambient = Theme.of(dialogContext);
          final bool showClear =
              (current.hasActiveFilters || showClearAllWhenEmpty) &&
              onClearAll != null;
          final Widget? footerWidget = (showClear || resultsCount != null)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (resultsCount != null)
                      Text(
                        l10n.filterResultsCount(resultsCount),
                        style: ambient.typography.textMuted.copyWith(
                          color: ambient.colors.mutedForeground,
                          fontSize: 13,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    if (showClear)
                      Button(
                        variant: ButtonVariant.ghost,
                        size: ButtonSize.md,
                        onPressed: onClearAll,
                        child: Text(l10n.filterClearAll),
                      ),
                  ],
                )
              : null;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:
                    (style?.overflowMenuWidth ?? tokens.overlayMaxWidth) *
                    ambient.scaling,
              ),
              child: FilterBarSheetScaffold(
                title: l10n.filterFilters,
                contentPadding: contentPadding,
                onClose: () => Navigator.of(dialogContext).pop(),
                footer: footerWidget,
                child:
                    dialogBuilder?.call(
                      dialogContext,
                      current,
                      () => Navigator.of(dialogContext).pop(),
                    ) ??
                    filterBarOverflowContent(
                      context: ctx,
                      current: current,
                      onEmit: onEmit,
                      tokens: tokens,
                      sortOptions: sortOptions,
                      enableDateRange: enableDateRange,
                      customFilters: customFilters,
                      trailingFilters: trailingFilters,
                      style: style,
                      theme: theme,
                      sortBuilder: sortBuilder,
                      dateBuilder: dateBuilder,
                    ),
              ),
            ),
          );
        },
      );
    },
  );
}
