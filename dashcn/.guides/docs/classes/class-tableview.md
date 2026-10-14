---
title: "Class: TableView"
description: "A themed data grid of [TableViewRow]s (headers, rows, footers) holding  [TableViewCell]s, sized by [TableSize] strategies."
---

```dart
/// A themed data grid of [TableViewRow]s (headers, rows, footers) holding
/// [TableViewCell]s, sized by [TableSize] strategies.
class TableView extends StatefulWidget {
  /// Creates a table.
  const TableView({super.key, required this.rows, this.defaultColumnWidth = const FlexTableSize(), this.defaultRowHeight = const IntrinsicTableSize(), this.columnWidths, this.rowHeights, this.clipBehavior = Clip.hardEdge, this.frozenCells, this.horizontalOffset, this.verticalOffset, this.viewportSize, this.verticalController, this.horizontalController, this.textDirection, this.resizeController, this.cellWidthResizeMode = TableCellResizeMode.reallocate, this.cellHeightResizeMode = TableCellResizeMode.expand, this.onRowTap, this.theme});
  /// Rows of the table.
  final List<TableViewRow> rows;
  /// Default column sizing strategy.
  final TableSize defaultColumnWidth;
  /// Default row sizing strategy.
  final TableSize defaultRowHeight;
  /// Per-column / per-row sizing overrides.
  final Map<int, TableSize>? columnWidths;
  final Map<int, TableSize>? rowHeights;
  /// How content is clipped at the table boundary.
  final Clip clipBehavior;
  /// Frozen rows/columns kept visible while scrolling.
  final FrozenTableData? frozenCells;
  /// Manual scroll offsets and viewport size (used when no controllers).
  final double? horizontalOffset;
  final double? verticalOffset;
  final Size? viewportSize;
  /// Own scrolling controllers; when set the table wraps a `ScrollableClient`.
  final ScrollController? verticalController;
  final ScrollController? horizontalController;
  /// Direction columns run in; defaults to the ambient `Directionality`.
  final TextDirection? textDirection;
  /// Enables interactive resizing when non-null.
  final ResizableTableController? resizeController;
  /// Column / row resize behaviour when [resizeController] is set.
  final TableCellResizeMode cellWidthResizeMode;
  /// Cell height strategy while a row resize drag runs.
  final TableCellResizeMode cellHeightResizeMode;
  /// Called with the row index when a body row is activated (tap, Enter or
  /// Space). Header and footer rows never report; null keeps every row inert.
  final ValueChanged<int>? onRowTap;
  /// Widget-leg theme override, merged on top of the other resolver legs.
  final TableTheme? theme;
  State<TableView> createState();
}
```
