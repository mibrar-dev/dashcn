---
title: "Class: FilterField"
description: "A typed custom filter keyed by [id]."
---

```dart
/// A typed custom filter keyed by [id].
class FilterField<T> {
  /// Creates a filter field.
  const FilterField({required this.id, this.label, this.matcher, this.matchers = const [], this.defaultMatcherId});
  /// Key under which the value is stored in `customFilters`.
  final String id;
  /// Optional display label.
  final String? label;
  /// Fallback matcher when [matchers] is empty.
  final FilterMatcher<T>? matcher;
  /// Selectable matchers; empty means a single [matcher].
  final List<FilterMatcherOption<T>> matchers;
  /// Matcher selected until the user picks another.
  final String? defaultMatcherId;
}
```
