---
title: "Class: TableCellRange"
description: "A rectangular range of cells."
---

```dart
/// A rectangular range of cells.
class TableCellRange {
  /// Creates a range.
  const TableCellRange(this.column, this.row, this.columnSpan, this.rowSpan);
  /// Left column.
  final int column;
  /// Top row.
  final int row;
  /// Number of columns.
  final int columnSpan;
  /// Number of rows.
  final int rowSpan;
  /// Whether this range overlaps [other] along [axis].
  ///
  /// [Axis.vertical] compares columns, [Axis.horizontal] compares rows.
  bool intersects(TableCellRange other, Axis axis);
  bool operator ==(Object other);
  int get hashCode;
}
```
