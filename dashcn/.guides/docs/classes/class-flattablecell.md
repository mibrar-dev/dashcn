---
title: "Class: FlatTableCell"
description: "A cell flattened to its grid position."
---

```dart
/// A cell flattened to its grid position.
class FlatTableCell<T extends TableCellLike> implements TableCellPosition {
  /// Creates a flat cell.
  const FlatTableCell({required this.column, required this.row, required this.columnSpan, required this.rowSpan, required this.cell, required this.selected});
  final int column;
  final int row;
  final int columnSpan;
  final int rowSpan;
  /// The underlying cell model.
  final T cell;
  /// Whether the owning row is selected.
  final bool selected;
  FlatTableCell<T> shift(int column, int row);
}
```
