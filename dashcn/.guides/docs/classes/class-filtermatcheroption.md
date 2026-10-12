---
title: "Class: FilterMatcherOption"
description: "One selectable matcher of a [FilterField]."
---

```dart
/// One selectable matcher of a [FilterField].
class FilterMatcherOption<T> {
  /// Creates a matcher option.
  const FilterMatcherOption({required this.id, required this.label, required this.matcher});
  /// Stable id stored by `setMatcherIdOf`.
  final String id;
  /// Label shown by a matcher picker.
  final String label;
  /// The rule this option selects.
  final FilterMatcher<T> matcher;
}
```
