---
title: "Class: MasonryLayoutRender"
description: "The render box behind [MasonryLayout]."
---

```dart
/// The render box behind [MasonryLayout].
///
/// Pick the column count from [crossAxisCount] or the incoming width, lay every
/// child out at exactly the column width (its height is whatever the child
/// wants — nothing is stretched), then drop it into the shortest column. The
/// box is as tall as its tallest column, minus one row gap.
class MasonryLayoutRender extends RenderBox with ContainerRenderObjectMixin<RenderBox, MasonryParentData>, RenderBoxContainerDefaultsMixin<RenderBox, MasonryParentData> {
  /// Creates the render box.
  MasonryLayoutRender({required this.crossAxisCount, required this.maxCrossAxisExtent, required this.mainAxisSpacing, required this.crossAxisSpacing, required this.textDirection});
  /// Fixed column count; null means "derive it from the incoming width".
  int? crossAxisCount;
  /// Target column width when the count is derived; null means "use the count".
  double? maxCrossAxisExtent;
  /// Space kept between two children stacked in one column.
  double mainAxisSpacing;
  /// Space kept between two neighbouring columns.
  double crossAxisSpacing;
  /// Direction the columns run in; null resolves `TextDirection.ltr`.
  TextDirection? textDirection;
  void setupParentData(covariant RenderObject child);
  /// Number of columns that fit [width].
  int columnsFor(double width);
  void performLayout();
  double computeMinIntrinsicWidth(double height);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  void paint(PaintingContext context, Offset offset);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  void visitChildrenForSemantics(RenderObjectVisitor visitor);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
