---
title: "Class: TableRef"
description: "A pinned row or column range."
---

```dart
/// A pinned row or column range.
class TableRef {
  /// Creates a reference to [span] rows/columns starting at [index].
  const TableRef(this.index, [this.span = 1]);
  /// First index of the range.
  final int index;
  /// Number of rows/columns in the range.
  final int span;
  /// Whether [index] falls inside this range.
  bool test(int index, int span);
}
```
