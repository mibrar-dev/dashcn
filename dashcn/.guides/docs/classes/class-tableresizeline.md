---
title: "Class: TableResizeLine"
description: "A hovered or dragged resize boundary."
---

```dart
/// A hovered or dragged resize boundary.
class TableResizeLine {
  /// Creates a boundary at [index] along [direction].
  const TableResizeLine(this.index, this.direction);
  /// Boundary index.
  final int index;
  /// `Axis.horizontal` for a row boundary, `Axis.vertical` for a column one.
  final Axis direction;
  bool operator ==(Object other);
  int get hashCode;
}
```
