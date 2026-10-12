---
title: "Class: FilterSortOption"
description: "One sort dropdown option."
---

```dart
/// One sort dropdown option.
class FilterSortOption {
  /// Creates a sort option.
  const FilterSortOption({required this.id, required this.label});
  /// Stable id stored in [FilterState.sortId].
  final String id;
  /// Dropdown text.
  final String label;
  bool operator ==(Object other);
  int get hashCode;
}
```
