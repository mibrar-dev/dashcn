---
title: "Class: CellResizer"
description: "The drag handles that resize a cell's column and row boundaries."
---

```dart
/// The drag handles that resize a cell's column and row boundaries.
///
/// Place it in a `Positioned.fill` over the cell content. It draws nothing
/// until a handle is hovered or dragged, when it paints [color].
class CellResizer extends StatefulWidget {
  /// Creates a cell resizer.
  const CellResizer({super.key, required this.controller, required this.row, required this.column, required this.rowSpan, required this.columnSpan, required this.maxRow, required this.maxColumn, required this.widthMode, required this.heightMode, required this.textDirection, required this.thickness, required this.color, required this.hoverNotifier, required this.dragNotifier, required this.onHover, required this.onDrag});
  /// Sizing controller that receives the resize results.
  final ResizableTableController controller;
  /// Row index of the cell.
  final int row;
  /// Column index of the cell.
  final int column;
  /// Number of rows the cell spans.
  final int rowSpan;
  /// Number of columns the cell spans.
  final int columnSpan;
  /// Last row index of the table.
  final int maxRow;
  /// Last column index of the table.
  final int maxColumn;
  /// Column resize behaviour.
  final TableCellResizeMode widthMode;
  /// Row resize behaviour.
  final TableCellResizeMode heightMode;
  /// Direction columns run in (mirrors the horizontal drag).
  final TextDirection textDirection;
  /// Thickness of each handle.
  final double thickness;
  /// Colour painted while a handle is active.
  final Color color;
  /// Shared notifier of the hovered boundary.
  final ValueNotifier<TableResizeLine?> hoverNotifier;
  /// Shared notifier of the dragged boundary.
  final ValueNotifier<TableResizeLine?> dragNotifier;
  /// Called when a boundary hover starts or ends.
  final TableResizeHoverCallback onHover;
  /// Called when a boundary drag starts or ends.
  final TableResizeHoverCallback onDrag;
  State<CellResizer> createState();
}
```
