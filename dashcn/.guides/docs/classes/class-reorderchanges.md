---
title: "Class: ReorderChanges"
description: "A batch of [ReorderChange]s applied in order."
---

```dart
/// A batch of [ReorderChange]s applied in order.
class ReorderChanges<T> {
  /// Creates a batch.
  const ReorderChanges(this.changes);
  /// The changes, applied in order.
  final List<ReorderChange<T>> changes;
  /// Whether the batch does nothing.
  bool get isEmpty;
  /// Whether the batch has at least one change.
  bool get isNotEmpty;
  /// Applies every change; returns how many were applied.
  int apply(List<T> list);
  /// Applies every change to a copy of [items] and returns it.
  List<T> appliedTo(List<T> items);
}
```
