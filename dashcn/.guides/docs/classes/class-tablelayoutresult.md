---
title: "Class: TableLayoutResult"
description: "Result of one table layout pass."
---

```dart
/// Result of one table layout pass.
class TableLayoutResult {
  /// Creates a layout result.
  TableLayoutResult({required this.columnWidths, required this.rowHeights, required this.remainingWidth, required this.remainingHeight, required this.remainingLooseWidth, required this.remainingLooseHeight, required this.hasTightFlexWidth, required this.hasTightFlexHeight});
  /// Computed width of each column.
  final List<double> columnWidths;
  /// Computed height of each row.
  final List<double> rowHeights;
  /// Width left after fixed and flex columns.
  final double remainingWidth;
  /// Height left after fixed and flex rows.
  final double remainingHeight;
  /// Loose width left for loose flex columns.
  final double remainingLooseWidth;
  /// Loose height left for loose flex rows.
  final double remainingLooseHeight;
  /// Whether any column is tightly flexible.
  final bool hasTightFlexWidth;
  /// Whether any row is tightly flexible.
  final bool hasTightFlexHeight;
  /// Top-left offset of the cell at [column], [row].
  Offset getOffset(int column, int row);
  /// Total size of the table.
  Size get size;
  /// Sum of all column widths.
  double get width;
  /// Sum of all row heights.
  double get height;
}
```
