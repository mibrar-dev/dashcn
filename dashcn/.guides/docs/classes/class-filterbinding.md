---
title: "Class: FilterBinding"
description: "Tests one model against one [FilterState]."
---

```dart
/// Tests one model against one [FilterState].
abstract class FilterBinding<TModel> {
  /// Creates a binding.
  const FilterBinding();
  /// Whether [model] passes this binding under [state].
  bool matches(FilterState state, TModel model);
}
```
