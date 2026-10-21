// The `filter_bar` component: search, sort, date, custom filters, chips,
// clear-all action and compact overflow menu / mobile sheet presentation.
//
// Widgets-only. Density-driven (compact default): control heights, icon sizes
// and gaps follow theme tokens. Overflow to compact menu on narrow widths.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../primitives/filter_core/filter_controller.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../drawer/drawer.dart';
import 'filter_bar_body.dart';
import 'filter_bar_search.dart';
import 'filter_bar_style.dart';

export '../../primitives/filter_core/filter_controller.dart'
    show
        FilterBarController,
        FilterClearPolicy,
        FilterStateExtensions,
        TypedFilterBinding;
export '../../primitives/filter_core/filter_matching.dart'
    show
        FilterBinding,
        FilterField,
        FilterMatcher,
        FilterMatcherOption,
        FilterMatchers;
export '../../primitives/filter_core/filter_state.dart'
    show FilterChipData, FilterDateRange, FilterSortOption, FilterState;
export 'filter_bar_controls.dart';
export 'filter_bar_dialog.dart';
export 'filter_bar_inline.dart';
export 'filter_bar_layout.dart';
export 'filter_bar_menu.dart';
export 'filter_bar_sheet.dart';
export 'filter_bar_style.dart';
export '../drawer/drawer.dart' show OverlayPosition;

/// A controlled/uncontrolled filter bar with density sizing and menu overflow.
class FilterBar extends StatefulWidget {
  /// Creates a filter bar.
  const FilterBar({
    super.key,
    this.state,
    this.onStateChanged,
    this.controller,
    this.initialState,
    this.sortOptions = const <FilterSortOption>[],
    this.enableDateRange = false,
    this.resultsCount,
    this.searchDebounce,
    this.trailingFilters = const <Widget>[],
    this.customFilters = const <FilterCustomFilter>[],
    this.clearPolicy = const FilterClearPolicy(),
    this.onClearAll,
    this.showClearAllWhenEmpty = false,
    this.presentation = FilterBarPresentation.inline,
    this.sheetBreakpoint = 720,
    this.sheetPosition = OverlayPosition.bottom,
    this.useRootNavigator = true,
    this.sheetContentPadding,
    this.groups = const <FilterGroup>[],
    this.theme,
    this.style,
    this.densityTokens,
    this.leading,
    this.trailing,
    this.searchBuilder,
    this.sortBuilder,
    this.dateBuilder,
    this.clearAllBuilder,
    this.triggerBuilder,
    this.chipBuilder,
    this.counterBuilder,
    this.overflowMenuBuilder,
    this.sheetBuilder,
  }) : assert(
         controller == null || (state == null && onStateChanged == null),
         'controller and state/onStateChanged are mutually exclusive.',
       );

  final FilterState? state;
  final ValueChanged<FilterState>? onStateChanged;
  final FilterBarController? controller;
  final FilterState? initialState;
  final List<FilterSortOption> sortOptions;
  final bool enableDateRange;
  final int? resultsCount;
  final Duration? searchDebounce;
  final List<Widget> trailingFilters;
  final List<FilterCustomFilter> customFilters;
  final FilterClearPolicy clearPolicy;
  final FilterBarClearResolver? onClearAll;
  final bool showClearAllWhenEmpty;
  final FilterBarPresentation presentation;
  final double sheetBreakpoint;
  final OverlayPosition sheetPosition;
  final bool useRootNavigator;
  final EdgeInsetsGeometry? sheetContentPadding;
  final List<FilterGroup> groups;
  final FilterBarTheme? theme;
  final FilterBarStyle? style;
  final DensityTokens? densityTokens;

  final Widget? leading;
  final Widget? trailing;
  final Widget Function(
    BuildContext,
    TextEditingController,
    ValueChanged<String>,
  )?
  searchBuilder;
  final Widget Function(
    BuildContext,
    String?,
    List<FilterSortOption>,
    ValueChanged<String?>,
  )?
  sortBuilder;
  final Widget Function(
    BuildContext,
    FilterDateRange?,
    ValueChanged<FilterDateRange?>,
  )?
  dateBuilder;
  final Widget Function(BuildContext, bool, VoidCallback)? clearAllBuilder;
  final Widget Function(BuildContext, int, VoidCallback)? triggerBuilder;
  final Widget Function(BuildContext, FilterChipData, VoidCallback)?
  chipBuilder;
  final Widget Function(BuildContext, int?, int)? counterBuilder;
  final Widget Function(BuildContext, FilterState, VoidCallback)?
  overflowMenuBuilder;
  final Widget Function(BuildContext, FilterState, VoidCallback)? sheetBuilder;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late final TextEditingController _search = TextEditingController(
    text: _current.search,
  );
  final ValueNotifier<FilterState> _mirror = ValueNotifier<FilterState>(
    const FilterState(),
  );
  FilterBarController? _internalController;
  Timer? _debounce;
  String _emittedSearch = '';
  FilterBarController? _attached;

  FilterState get _current =>
      widget.controller?.value ??
      widget.state ??
      _internalController?.value ??
      const FilterState();

  FilterBarTheme _theme(BuildContext context) =>
      resolveComponentStyle<FilterBarTheme, FilterBarTheme>(
        context,
        widget: widget.theme,
        select: (t) => t,
        defaults: filterBarDefaults,
      );

  DensityTokens _tokens(BuildContext context) =>
      widget.densityTokens ??
      widget.theme?.themeDensityTokens ??
      ComponentTheme.maybeOf<FilterBarTheme>(context)?.themeDensityTokens ??
      ComponentThemes.maybeOf<FilterBarTheme>(context)?.themeDensityTokens ??
      resolveDensityTokens(context);

  @override
  void initState() {
    super.initState();
    if (widget.controller == null && widget.state == null) {
      _internalController = FilterBarController(
        widget.initialState ?? const FilterState(),
      );
      _attached = _internalController;
    } else {
      _attached = widget.controller;
    }
    _attached?.addListener(_onControllerChanged);
    _emittedSearch = _current.search;
    _mirror.value = _current;
  }

  @override
  void didUpdateWidget(covariant FilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _attached?.removeListener(_onControllerChanged);
      _attached = widget.controller ?? _internalController;
      _attached?.addListener(_onControllerChanged);
    }
    if (widget.searchDebounce != oldWidget.searchDebounce) _debounce?.cancel();
    _syncSearch();
    _mirror.value = _current;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _attached?.removeListener(_onControllerChanged);
    _internalController?.dispose();
    _search.dispose();
    _mirror.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    _syncSearch();
    _mirror.value = _current;
    if (mounted) setState(() {});
  }

  void _syncSearch() {
    final String next = _current.search;
    if (next != _emittedSearch) {
      _emittedSearch = next;
      syncFilterSearchText(
        controller: _search,
        nextText: next,
        lastEmittedText: _emittedSearch,
      );
    }
  }

  void _emit(FilterState next) {
    if (next == _current) return;
    _mirror.value = next;
    widget.controller?.setValue(next);
    _internalController?.setValue(next);
    widget.onStateChanged?.call(next);
    if (widget.controller == null && _internalController == null) {
      setState(() {});
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _emittedSearch = value;
    void emit() => _emit(_current.copyWith(search: value));
    final Duration? delay = widget.searchDebounce;
    if (delay == null || delay == Duration.zero) {
      emit();
    } else {
      _debounce = Timer(delay, () {
        if (mounted) emit();
      });
    }
  }

  void _clearAll() {
    _debounce?.cancel();
    final FilterState next =
        widget.onClearAll?.call(_current) ??
        _current.cleared(policy: widget.clearPolicy);
    _emittedSearch = next.search;
    if (_search.text != next.search) _search.text = next.search;
    _emit(next);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return buildFilterBarResponsive(
          context: context,
          constraints: constraints,
          widget: widget,
          current: _current,
          stateMirror: _mirror,
          searchController: _search,
          onEmit: _emit,
          onClearAll: _clearAll,
          onSearchChanged: _onSearchChanged,
          theme: _theme(context),
          tokens: _tokens(context),
        );
      },
    );
  }
}
