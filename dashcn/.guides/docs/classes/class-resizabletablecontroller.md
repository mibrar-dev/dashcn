---
title: "Class: ResizableTableController"
description: "Programmatic column-width and row-height state for a resizable table."
---

```dart
/// Programmatic column-width and row-height state for a resizable table.
///
/// Notifies listeners when a column or row changes so the table can relayout.
class ResizableTableController extends ChangeNotifier {
  /// Creates a controller.
  ResizableTableController({this._columnWidths, required this._defaultColumnWidth, this._rowHeights, required this._defaultRowHeight, this._defaultWidthConstraint, this._defaultHeightConstraint, this._widthConstraints, this._heightConstraints});
  /// Resizes [column] to [width]; returns whether the value changed.
  bool resizeColumn(int column, double width);
  /// Resizes [row] to [height]; returns whether the value changed.
  bool resizeRow(int row, double height);
  /// Moves [deltaWidth] across the border between two columns.
  double resizeColumnBorder(int previousColumn, int nextColumn, double deltaWidth);
  /// Moves [deltaHeight] across the border between two rows.
  double resizeRowBorder(int previousRow, int nextRow, double deltaHeight);
  /// Unmodifiable custom column widths, or null when none were set.
  Map<int, double>? get columnWidths;
  /// Unmodifiable custom row heights, or null when none were set.
  Map<int, double>? get rowHeights;
  /// Width of [index].
  double getColumnWidth(int index);
  /// Height of [index].
  double getRowHeight(int index);
  /// Minimum height of [index], if constrained.
  double? getRowMinHeight(int index);
  /// Maximum height of [index], if constrained.
  double? getRowMaxHeight(int index);
  /// Minimum width of [index], if constrained.
  double? getColumnMinWidth(int index);
  /// Maximum width of [index], if constrained.
  double? getColumnMaxWidth(int index);
}
```
