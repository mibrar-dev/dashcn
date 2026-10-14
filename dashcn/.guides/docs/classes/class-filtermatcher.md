---
title: "Class: FilterMatcher"
description: "One reusable matching rule."
---

```dart
/// One reusable matching rule.
class FilterMatcher<T> {
  /// Creates a matcher from its callback.
  const FilterMatcher(this._matches);
  /// Whether [candidate] passes the rule for [selected].
  bool matches(T selected, Object? candidate);
}
```
