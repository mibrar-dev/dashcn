---
title: "Class: TableCellPosition"
description: "A cell's grid position and span."
---

```dart
/// A cell's grid position and span.
abstract class TableCellPosition {
  /// Column index.
  int get column;
  /// Row index.
  int get row;
  /// Number of columns spanned.
  int get columnSpan;
  /// Number of rows spanned.
  int get rowSpan;
  /// A copy moved by [column], [row] cells.
  TableCellPosition shift(int column, int row);
}
```
