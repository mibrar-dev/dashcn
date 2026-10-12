---
title: "Class: ReorderRemove"
description: "Removes the item at [index]."
---

```dart
/// Removes the item at [index].
class ReorderRemove<T> extends ReorderChange<T> {
  /// Creates a removal.
  const ReorderRemove(this.index);
  /// Index of the item to remove.
  final int index;
  bool apply(List<T> list);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
