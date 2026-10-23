// Sheet presentation scaffold for `filter_bar`.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/surface.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../drawer/drawer.dart';
import 'filter_bar_layout.dart';
import 'filter_bar_style.dart';

/// The card used inside the mobile filter sheet.
class FilterBarSheetScaffold extends StatelessWidget {
  /// Creates a sheet scaffold.
  const FilterBarSheetScaffold({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
    this.footer,
    this.maxHeight = 560,
    this.contentPadding,
  });

  /// Sheet title.
  final String title;

  /// Sheet body.
  final Widget child;

  /// Called by the close button; null hides it.
  final VoidCallback? onClose;

  /// Optional footer pinned below the body.
  final Widget? footer;

  /// Maximum card height before the body scrolls.
  final double maxHeight;

  /// Padding around the body.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final double scale = ambient.scaling;
    final double? opacity = resolveSurfaceOpacity(context);
    final double? blur = resolveSurfaceBlur(context);
    final Color fill = surfaceColor(ambient.colors.card, opacity);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ambient.spacing.sm),
        child: GlassSurface(
          surfaceBlur: blur,
          borderRadius: ambient.borderRadiusXl,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              border: Border.all(color: ambient.colors.border),
              borderRadius: ambient.borderRadiusXl,
              boxShadow: ambient.tokens.shadows.shadowLg,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight * scale),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      ambient.spacing.md,
                      ambient.spacing.sm,
                      ambient.spacing.sm,
                      ambient.spacing.sm,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            title,
                            style: ambient.typography.large.copyWith(
                              color: ambient.colors.foreground,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (onClose != null)
                          Button(
                            variant: ButtonVariant.ghost,
                            size: ButtonSize.icon,
                            onPressed: onClose,
                            child: const Icon(LucideIcons.x, size: 16),
                          ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding:
                          contentPadding ??
                          EdgeInsetsDirectional.fromSTEB(
                            ambient.spacing.md,
                            0,
                            ambient.spacing.md,
                            ambient.spacing.md,
                          ),
                      child: child,
                    ),
                  ),
                  if (footer != null)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        ambient.spacing.md,
                        0,
                        ambient.spacing.md,
                        ambient.spacing.md,
                      ),
                      child: footer,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the mobile drawer sheet for [FilterBar].
Future<void> openFilterBarSheet({
  required BuildContext context,
  required ValueNotifier<FilterState> stateMirror,
  required DensityTokens tokens,
  required FilterBarTheme theme,
  required ValueChanged<FilterState> onEmit,
  required List<FilterSortOption> sortOptions,
  required bool enableDateRange,
  required List<FilterCustomFilter> customFilters,
  required List<Widget> trailingFilters,
  required OverlayPosition sheetPosition,
  required bool useRootNavigator,
  EdgeInsetsGeometry? sheetContentPadding,
  VoidCallback? onClearAll,
  bool showClearAllWhenEmpty = false,
  int? resultsCount,
  FilterBarStyle? style,
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
  Widget Function(BuildContext, FilterState, VoidCallback)? sheetBuilder,
}) {
  return openSheet<void>(
    context: context,
    position: sheetPosition,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext sheetContext) {
      return ValueListenableBuilder<FilterState>(
        valueListenable: stateMirror,
        builder: (BuildContext ctx, FilterState current, _) {
          final ComponentLocalizations l10n = ComponentLocalizations.of(
            sheetContext,
          );
          final ThemeData ambient = Theme.of(sheetContext);
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

          return FilterBarSheetScaffold(
            title: l10n.filterFilters,
            contentPadding: sheetContentPadding,
            onClose: () => closeSheet(sheetContext),
            footer: footerWidget,
            child:
                sheetBuilder?.call(
                  sheetContext,
                  current,
                  () => closeSheet(sheetContext),
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
          );
        },
      );
    },
  );
}
