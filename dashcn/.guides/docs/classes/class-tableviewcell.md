---
title: "Class: TableViewCell"
description: "One cell of a `table`."
---

```dart
/// One cell of a `table`.
class TableViewCell implements TableCellLike {
  /// Creates a cell.
  const TableViewCell({this.columnSpan = 1, this.rowSpan = 1, required this.child, this.columnHover = false, this.rowHover = true, this.enabled = true});
  final int columnSpan;
  final int rowSpan;
  /// Cell content.
  final Widget child;
  /// Whether hovering another cell in the same column / row highlights this
  /// one.
  final bool columnHover;
  final bool rowHover;
  /// Whether the cell responds to hover.
  final bool enabled;
  bool operator ==(Object other);
  int get hashCode;
}
```
