---
title: "Class: OverlapLayoutRender"
description: "The two-child render box behind [OverlapLayout]: [firstChild] is the  primary child, the next sibling is the overlap."
---

```dart
/// The two-child render box behind [OverlapLayout]: [firstChild] is the
/// primary child, the next sibling is the overlap.
class OverlapLayoutRender extends RenderBox with ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>, RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  /// Creates the overlap render box.
  OverlapLayoutRender({required this._corner, required this._alignment, required this._gap, required this._extraWidth});
  /// Corner the overlap hangs from.
  set corner(OverlapCorner value);
  /// Side the union is aligned to.
  set alignment(Alignment value);
  /// Distance between overlap and primary edges.
  set gap(double value);
  /// Extra width kept when the overlap is wider.
  set extraWidth(double value);
  void setupParentData(covariant RenderObject child);
  void performLayout();
  Size computeDryLayout(covariant BoxConstraints constraints);
  double computeMinIntrinsicWidth(double height);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  void paint(PaintingContext context, Offset offset);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
