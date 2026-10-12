---
title: "Class: ReorderInsert"
description: "Inserts [item] at [index]."
---

```dart
/// Inserts [item] at [index].
class ReorderInsert<T> extends ReorderChange<T> {
  /// Creates an insertion.
  const ReorderInsert(this.index, this.item);
  /// Target index; clamped into `[0, length]` on apply.
  final int index;
  /// The item to insert.
  final T item;
  bool apply(List<T> list);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
