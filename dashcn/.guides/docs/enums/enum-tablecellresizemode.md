---
title: "Enum: TableCellResizeMode"
description: "How a table cell resizes when its handle is dragged."
---

```dart
/// How a table cell resizes when its handle is dragged.
enum TableCellResizeMode {
  /// Only the dragged cell grows.
  expand,
  /// The dragged cell grows and its neighbour shrinks.
  reallocate,
  /// Resizing is disabled.
  none,
}
```
