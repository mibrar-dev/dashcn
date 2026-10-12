---
title: "Class: ReorderSwap"
description: "Swaps the items at [from] and [to]."
---

```dart
/// Swaps the items at [from] and [to].
class ReorderSwap<T> extends ReorderChange<T> {
  /// Creates a swap.
  const ReorderSwap(this.from, this.to);
  /// Source index.
  final int from;
  /// Destination index.
  final int to;
  bool apply(List<T> list);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
