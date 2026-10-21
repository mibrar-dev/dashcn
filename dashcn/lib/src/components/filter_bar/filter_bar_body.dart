// Responsive layout and trigger handling for `filter_bar`.

import 'package:flutter/widgets.dart';

import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'filter_bar.dart';

/// Builds the decorated filter bar container with responsive overflow.
Widget buildFilterBarResponsive({
  required BuildContext context,
  required BoxConstraints constraints,
  required FilterBar widget,
  required FilterState current,
  required ValueNotifier<FilterState> stateMirror,
  required TextEditingController searchController,
  required ValueChanged<FilterState> onEmit,
  required VoidCallback onClearAll,
  required ValueChanged<String> onSearchChanged,
  required FilterBarTheme theme,
  required DensityTokens tokens,
}) {
  final ThemeData ambient = Theme.of(context);
  final FilterBarStyle? st = widget.style;
  final double sp = st?.spacing ?? theme.spacing ?? tokens.gap;
  final double runSp = st?.runSpacing ?? theme.runSpacing ?? kSpace2;
  final double searchW = st?.searchWidth ?? theme.searchWidth ?? 220;

  final bool overflow = switch (widget.presentation) {
    FilterBarPresentation.inline => false,
    FilterBarPresentation.sheet ||
    FilterBarPresentation.menu ||
    FilterBarPresentation.popup ||
    FilterBarPresentation.dialog => true,
    FilterBarPresentation.autoSheet || FilterBarPresentation.autoMenu =>
      constraints.maxWidth.isFinite &&
          constraints.maxWidth < widget.sheetBreakpoint,
  };

  final bool isMenu = switch (widget.presentation) {
    FilterBarPresentation.menu ||
    FilterBarPresentation.popup ||
    FilterBarPresentation.autoMenu => true,
    FilterBarPresentation.sheet ||
    FilterBarPresentation.autoSheet ||
    FilterBarPresentation.dialog ||
    FilterBarPresentation.inline => false,
  };

  final bool isDialog = widget.presentation == FilterBarPresentation.dialog;

  final Widget searchWidget =
      widget.searchBuilder?.call(context, searchController, onSearchChanged) ??
      FilterBarSearchField(
        controller: searchController,
        onChanged: onSearchChanged,
        width: searchW,
        height: st?.controlHeight ?? theme.controlHeight,
        iconSize: st?.iconSize ?? theme.iconSize ?? tokens.iconSize,
        textStyle: st?.textStyle,
        densityTokens: tokens,
      );

  void handleOpen(BuildContext btnContext) {
    if (isDialog) {
      openFilterBarDialog(
        context: btnContext,
        stateMirror: stateMirror,
        tokens: tokens,
        theme: theme,
        onEmit: onEmit,
        sortOptions: widget.sortOptions,
        enableDateRange: widget.enableDateRange,
        customFilters: widget.customFilters,
        trailingFilters: widget.trailingFilters,
        showClearAllWhenEmpty: widget.showClearAllWhenEmpty,
        style: st,
        resultsCount: widget.resultsCount,
        onClearAll: onClearAll,
        contentPadding: widget.sheetContentPadding,
        sortBuilder: widget.sortBuilder,
        dateBuilder: widget.dateBuilder,
      );
    } else if (isMenu) {
      openFilterBarMenu(
        triggerContext: btnContext,
        stateMirror: stateMirror,
        tokens: tokens,
        theme: theme,
        onEmit: onEmit,
        onClearAll: onClearAll,
        sortOptions: widget.sortOptions,
        enableDateRange: widget.enableDateRange,
        customFilters: widget.customFilters,
        trailingFilters: widget.trailingFilters,
        showClearAllWhenEmpty: widget.showClearAllWhenEmpty,
        style: st,
        resultsCount: widget.resultsCount,
        sortBuilder: widget.sortBuilder,
        dateBuilder: widget.dateBuilder,
        overflowMenuBuilder: widget.overflowMenuBuilder,
      );
    } else {
      openFilterBarSheet(
        context: context,
        stateMirror: stateMirror,
        tokens: tokens,
        theme: theme,
        onEmit: onEmit,
        onClearAll: onClearAll,
        showClearAllWhenEmpty: widget.showClearAllWhenEmpty,
        resultsCount: widget.resultsCount,
        sortOptions: widget.sortOptions,
        enableDateRange: widget.enableDateRange,
        customFilters: widget.customFilters,
        trailingFilters: widget.trailingFilters,
        sheetPosition: widget.sheetPosition,
        useRootNavigator: widget.useRootNavigator,
        sheetContentPadding: widget.sheetContentPadding,
        style: st,
        sortBuilder: widget.sortBuilder,
        dateBuilder: widget.dateBuilder,
        sheetBuilder: widget.sheetBuilder,
      );
    }
  }

  final bool hasOverflowContent =
      widget.sortOptions.isNotEmpty ||
      widget.enableDateRange ||
      widget.customFilters.isNotEmpty ||
      widget.trailingFilters.isNotEmpty ||
      current.chips.isNotEmpty;

  final Widget body = overflow
      ? filterBarOverflowBody(
          context: context,
          current: current,
          onEmit: onEmit,
          tokens: tokens,
          searchWidget: searchWidget,
          hasOverflowContent: hasOverflowContent,
          onOpen: () => handleOpen(context),
          sp: sp,
          runSp: runSp,
          leading: widget.leading,
          trailing: widget.trailing,
          style: st,
          theme: theme,
          triggerBuilder: widget.triggerBuilder != null
              ? (BuildContext ctx, int count, VoidCallback _) =>
                    widget.triggerBuilder!(ctx, count, () => handleOpen(ctx))
              : null,
          chipBuilder: widget.chipBuilder,
        )
      : filterBarInlineLayout(
          context: context,
          current: current,
          onEmit: onEmit,
          onClearAll: onClearAll,
          tokens: tokens,
          searchWidget: searchWidget,
          sortOptions: widget.sortOptions,
          enableDateRange: widget.enableDateRange,
          customFilters: widget.customFilters,
          groups: widget.groups,
          trailingFilters: widget.trailingFilters,
          showClearAllWhenEmpty: widget.showClearAllWhenEmpty,
          sp: sp,
          runSp: runSp,
          resultsCount: widget.resultsCount,
          leading: widget.leading,
          trailing: widget.trailing,
          style: st,
          theme: theme,
          sortBuilder: widget.sortBuilder,
          dateBuilder: widget.dateBuilder,
          clearAllBuilder: widget.clearAllBuilder,
          chipBuilder: widget.chipBuilder,
          counterBuilder: widget.counterBuilder,
        );

  final EdgeInsetsGeometry pad =
      st?.padding ??
      EdgeInsets.symmetric(
        horizontal: tokens.horizontalPadding,
        vertical: (st?.dense ?? theme.dense ?? false) ? kSpace1 : kSpace2,
      );

  return DecoratedBox(
    decoration: BoxDecoration(
      color: st?.backgroundColor,
      border: Border.all(color: st?.borderColor ?? ambient.colors.border),
      borderRadius: st?.borderRadius ?? ambient.borderRadiusMd,
      boxShadow: st?.elevation,
    ),
    child: Padding(padding: pad, child: body),
  );
}
