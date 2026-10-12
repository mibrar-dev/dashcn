---
title: "Class: ReorderChange"
description: "Base class of a single reorder operation on a list."
---

```dart
/// Base class of a single reorder operation on a list.
///
/// Implementations are immutable and describe intent, so the owning component
/// can report them to a form before applying them.
class ReorderChange<T> {
  /// Creates a change.
  const ReorderChange();
  /// Applies this change to [list]; returns false when it was skipped.
  ///
  /// The old `ListChange` hierarchy threw a [RangeError] when an index was out
  /// of range. Every implementation here is bounds checked and reports the skip
  /// instead, so a stale index from an animation can never crash the list.
  bool apply(List<T> list);
}
```
