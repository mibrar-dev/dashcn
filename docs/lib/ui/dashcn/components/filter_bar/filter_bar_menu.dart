// Compact overflow menu for `filter_bar` on narrow widths.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/overlay.dart';
import '../../primitives/surface.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../popup/popup.dart';
import 'filter_bar_layout.dart';
import 'filter_bar_style.dart';

/// A compact floating overflow menu for [FilterBar] controls on narrow widths.
class FilterBarOverflowMenu extends StatelessWidget {
  /// Creates the compact overflow menu.
  const FilterBarOverflowMenu({
    super.key,
    required this.title,
    required this.child,
    this.activeCount = 0,
    this.resultsCount,
    this.onClose,
    this.onClearAll,
    this.width = 280,
    this.contentPadding,
  });

  /// Menu header title.
  final String title;

  /// Control content inside the menu.
  final Widget child;

  /// Number of active filters.
  final int activeCount;

  /// Optional count of filtered results.
  final int? resultsCount;

  /// Callback to close the menu.
  final VoidCallback? onClose;

  /// Callback to clear all active filters.
  final VoidCallback? onClearAll;

  /// Width of the menu; defaults to 280 (within 160..320 px compact bounds).
  final double width;

  /// Insets around the control content.
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final ComponentLocalizations l10n = ComponentLocalizations.of(context);
    final double? opacity = resolveSurfaceOpacity(context);
    final double? blur = resolveSurfaceBlur(context);
    final Color fill = surfaceColor(ambient.colors.card, opacity);

    return Focus(
      autofocus: true,
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (_) {
                onClose?.call();
                return null;
              },
            ),
          },
          child: GlassSurface(
            surfaceBlur: blur,
            borderRadius: ambient.borderRadiusLg,
            child: Container(
              width: width.clamp(
                kOverlayMinWidthCompact,
                kOverlayMaxWidthCompact,
              ),
              decoration: BoxDecoration(
                color: fill,
                border: Border.all(color: ambient.colors.border),
                borderRadius: ambient.borderRadiusLg,
                boxShadow: ambient.tokens.shadows.shadowLg,
              ),
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
                            activeCount > 0 ? '$title ($activeCount)' : title,
                            style: ambient.typography.base.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ambient.colors.foreground,
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
                  Container(height: 1, color: ambient.colors.border),
                  Flexible(
                    child: SingleChildScrollView(
                      padding:
                          contentPadding ??
                          EdgeInsetsDirectional.all(ambient.spacing.md),
                      child: child,
                    ),
                  ),
                  if (onClearAll != null || resultsCount != null) ...<Widget>[
                    Container(height: 1, color: ambient.colors.border),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        ambient.spacing.md,
                        ambient.spacing.sm,
                        ambient.spacing.md,
                        ambient.spacing.sm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (resultsCount != null)
                            Text(
                              l10n.filterResultsCount(resultsCount!),
                              style: ambient.typography.textMuted.copyWith(
                                color: ambient.colors.mutedForeground,
                                fontSize: 13,
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          if (onClearAll != null)
                            Button(
                              variant: ButtonVariant.ghost,
                              size: ButtonSize.md,
                              onPressed: onClearAll,
                              child: Text(l10n.filterClearAll),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the anchored compact overflow menu for [FilterBar].
Future<void> openFilterBarMenu({
  required BuildContext triggerContext,
  required ValueNotifier<FilterState> stateMirror,
  required DensityTokens tokens,
  required FilterBarTheme theme,
  required ValueChanged<FilterState> onEmit,
  required VoidCallback onClearAll,
  required List<FilterSortOption> sortOptions,
  required bool enableDateRange,
  required List<FilterCustomFilter> customFilters,
  required List<Widget> trailingFilters,
  required bool showClearAllWhenEmpty,
  FilterBarStyle? style,
  int? resultsCount,
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
  Widget Function(BuildContext, FilterState, VoidCallback)? overflowMenuBuilder,
}) {
  return showPopup<void>(
    context: triggerContext,
    alignment: AlignmentDirectional.topEnd,
    anchorAlignment: AlignmentDirectional.bottomEnd,
    offset: const Offset(0, 4),
    width: style?.overflowMenuWidth ?? 280,
    builder: (BuildContext menuContext) {
      return ValueListenableBuilder<FilterState>(
        valueListenable: stateMirror,
        builder: (BuildContext context, FilterState current, _) {
          final ComponentLocalizations l10n = ComponentLocalizations.of(
            context,
          );
          return overflowMenuBuilder?.call(
                menuContext,
                current,
                () => closeOverlay(menuContext),
              ) ??
              FilterBarOverflowMenu(
                title: l10n.filterFilters,
                activeCount: current.activeFilterCount,
                resultsCount: resultsCount,
                width: style?.overflowMenuWidth ?? 280,
                onClose: () => closeOverlay(menuContext),
                onClearAll: current.hasActiveFilters || showClearAllWhenEmpty
                    ? onClearAll
                    : null,
                child: filterBarOverflowContent(
                  context: context,
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
