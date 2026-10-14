---
title: "Class: TableRawCell"
description: "Positions a cell on the grid and overlays an optional resize handle."
---

```dart
/// Positions a cell on the grid and overlays an optional resize handle.
class TableRawCell extends StatelessWidget {
  /// Creates a raw table cell.
  const TableRawCell({super.key, required this.column, required this.row, required this.columnSpan, required this.rowSpan, required this.child, this.resizer});
  /// Column index.
  final int column;
  /// Row index.
  final int row;
  /// Number of columns spanned.
  final int columnSpan;
  /// Number of rows spanned.
  final int rowSpan;
  /// Cell content.
  final Widget child;
  /// Optional resize-handle overlay.
  final Widget? resizer;
  Widget build(BuildContext context);
}
```
