---
title: "Class: RenderTableLayout"
description: "Render object for [RawTableLayout]."
---

```dart
/// Render object for [RawTableLayout].
class RenderTableLayout extends RenderBox with ContainerRenderObjectMixin<RenderBox, TableParentData>, RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  /// Creates a table layout render object.
  RenderTableLayout({List<RenderBox>? children, required this._width, required this._height, required this._clipBehavior, this._frozenColumn, this._frozenRow, this._verticalOffset, this._horizontalOffset, this._viewportSize, this._textDirection = TextDirection.ltr});
  /// Column width supplier.
  set width(TableSizeSupplier value);
  /// Row height supplier.
  set height(TableSizeSupplier value);
  /// How content is clipped.
  set clipBehavior(Clip value);
  /// Frozen column predicate.
  set frozenColumn(CellPredicate? value);
  /// Frozen row predicate.
  set frozenRow(CellPredicate? value);
  /// Vertical scroll offset.
  set verticalOffset(double? value);
  /// Horizontal scroll offset.
  set horizontalOffset(double? value);
  /// Visible viewport size.
  set viewportSize(Size? value);
  /// Direction columns run in.
  set textDirection(TextDirection value);
  void setupParentData(RenderObject child);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  Size computeDryLayout(BoxConstraints constraints);
  void paint(PaintingContext context, Offset offset);
  void performLayout();
  /// Computes the grid for [constraints].
  TableLayoutResult computeTableSize(BoxConstraints constraints, [IntrinsicComputer? intrinsicComputer]);
  double computeMinIntrinsicWidth(double height);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  /// Computed width of each column.
  List<double> get columnWidths;
  /// Computed height of each row.
  List<double> get rowHeights;
  /// Top-left offset of the cell at [column], [row].
  Offset getOffset(int column, int row);
  /// Width left after fixed and flex columns.
  double get remainingWidth;
  /// Height left after fixed and flex rows.
  double get remainingHeight;
  /// Loose width left for loose flex columns.
  double get remainingLooseWidth;
  /// Loose height left for loose flex rows.
  double get remainingLooseHeight;
  /// Whether any column is tightly flexible.
  bool get hasTightFlexWidth;
  /// Whether any row is tightly flexible.
  bool get hasTightFlexHeight;
}
```
