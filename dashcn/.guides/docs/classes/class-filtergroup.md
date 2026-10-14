---
title: "Class: FilterGroup"
description: "One titled group of custom filters."
---

```dart
/// One titled group of custom filters.
class FilterGroup {
  /// Creates a group.
  const FilterGroup({required this.id, required this.title, this.filterIds = const <String>[], this.itemBuilder});
  /// Stable id.
  final String id;
  /// Group heading.
  final String title;
  /// Custom filter ids that belong to this group.
  final List<String> filterIds;
  /// Optional per-item renderer; when null the filter's own builder is used.
  final FilterCustomFilterBuilder? itemBuilder;
}
```
