---
title: "Class: FilterClearPolicy"
description: "Which parts of a [FilterState] `clear` resets."
---

```dart
/// Which parts of a [FilterState] `clear` resets.
class FilterClearPolicy {
  /// Creates a clear policy; everything clears by default.
  const FilterClearPolicy({this.clearSearch = true, this.clearSort = true, this.clearDateRange = true, this.clearChips = true, this.clearCustomFilters = true});
  /// Whether the search text clears.
  final bool clearSearch;
  /// Whether the sort id clears.
  final bool clearSort;
  /// Whether the date range clears.
  final bool clearDateRange;
  /// Whether chips clear.
  final bool clearChips;
  /// Whether custom filter values clear.
  final bool clearCustomFilters;
  /// Returns a copy with the given flags replaced.
  FilterClearPolicy copyWith({bool? clearSearch, bool? clearSort, bool? clearDateRange, bool? clearChips, bool? clearCustomFilters});
  bool operator ==(Object other);
  int get hashCode;
}
```
