---
title: "Class: FilterBar"
description: "A controlled filter bar: search, sort, date range, custom filters, chips  and an optional sheet presentation (`FilterBar(state: ."
---

```dart
/// A controlled filter bar: search, sort, date range, custom filters, chips
/// and an optional sheet presentation (`FilterBar(state: ..., ...)`).
class FilterBar extends StatefulWidget {
  /// Creates a filter bar; provide a [controller] or [state]+[onStateChanged].
  const FilterBar({super.key, this.state, this.onStateChanged, this.controller, this.sortOptions = const <FilterSortOption>[], this.enableDateRange = false, this.resultsCount, this.searchDebounce, this.trailingFilters = const <Widget>[], this.customFilters = const <FilterCustomFilter>[], this.clearPolicy = const FilterClearPolicy(), this.onClearAll, this.showClearAllWhenEmpty = false, this.presentation = FilterBarPresentation.autoSheet, this.sheetBreakpoint = 720, this.sheetPosition = OverlayPosition.bottom, this.useRootNavigator = true, this.sheetContentPadding, this.groups = const <FilterGroup>[], this.theme});
  final FilterState? state;
  final ValueChanged<FilterState>? onStateChanged;
  final FilterBarController? controller;
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
  State<FilterBar> createState();
}
```
