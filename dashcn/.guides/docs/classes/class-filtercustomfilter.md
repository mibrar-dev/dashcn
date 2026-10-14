---
title: "Class: FilterCustomFilter"
description: "One custom filter entry: [id] identifies it, [builder] renders it."
---

```dart
/// One custom filter entry: [id] identifies it, [builder] renders it.
class FilterCustomFilter {
  /// Creates a custom filter.
  const FilterCustomFilter({required this.id, required this.builder});
  /// Stable id.
  final String id;
  /// Renders the filter for the current state.
  final FilterCustomFilterBuilder builder;
  /// Creates a filter backed by a [FilterField], reading its value from the
  /// state and writing changes back.
  static FilterCustomFilter typed<T>({required FilterField<T> field, required FilterTypedCustomFilterBuilder<T> builder});
}
```
