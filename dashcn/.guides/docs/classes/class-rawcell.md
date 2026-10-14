---
title: "Class: RawCell"
description: "Positions a child inside a [RawTableLayout]."
---

```dart
/// Positions a child inside a [RawTableLayout].
class RawCell extends ParentDataWidget<TableParentData> {
  /// Creates a raw table cell.
  const RawCell({super.key, required this.column, required this.row, this.columnSpan, this.rowSpan, this.computeSize = true, required super.child});
  /// Column index.
  final int column;
  /// Row index.
  final int row;
  /// Number of columns spanned.
  final int? columnSpan;
  /// Number of rows spanned.
  final int? rowSpan;
  /// Whether this cell contributes to column/row sizing.
  final bool computeSize;
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
