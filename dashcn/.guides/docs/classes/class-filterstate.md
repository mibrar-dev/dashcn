---
title: "Class: FilterState"
description: "Immutable value of every filter a `filter_bar` carries."
---

```dart
/// Immutable value of every filter a `filter_bar` carries.
///
/// `copyWith` uses a sentinel for the nullable fields so `null` can be stored
/// deliberately (`sortId: null` clears the sort).
class FilterState {
  /// Free-text query.
  final String search;
  /// Selected sort option id, or null.
  final String? sortId;
  /// Selected date span, or null.
  final FilterDateRange? dateRange;
  /// Removable filter chips.
  final List<FilterChipData> chips;
  /// Custom filter values keyed by field id (matcher ids included).
  final Map<String, Object?> customFilters;
  /// Creates a filter state.
  const FilterState({this.search = '', this.sortId, this.dateRange, this.chips = const <FilterChipData>[], this.customFilters = const <String, Object?>{}});
  /// Returns a copy; the sentinel keeps explicit nulls.
  FilterState copyWith({String? search, Object? sortId = _sentinel, Object? dateRange = _sentinel, List<FilterChipData>? chips, Object? customFilters = _sentinel});
  bool operator ==(Object other);
  int get hashCode;
}
```
