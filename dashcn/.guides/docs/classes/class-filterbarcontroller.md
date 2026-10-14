---
title: "Class: FilterBarController"
description: "Notifies listeners whenever a [FilterState] changes."
---

```dart
/// Notifies listeners whenever a [FilterState] changes.
class FilterBarController extends ValueNotifier<FilterState> {
  /// Creates a controller around [value].
  FilterBarController([super.value = const FilterState()]);
  /// Replaces the state; equal states are ignored.
  void setValue(FilterState next);
  /// Applies [transform] to the current state.
  void update(FilterState Function(FilterState current) transform);
  /// Clears the state per [policy].
  void clear({FilterClearPolicy policy = const FilterClearPolicy()});
}
```
