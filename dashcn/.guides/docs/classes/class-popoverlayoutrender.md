---
title: "Class: PopoverLayoutRender"
description: "Custom render object for popover positioning."
---

```dart
/// Custom render object for popover positioning.
class PopoverLayoutRender extends RenderShiftedBox {
  /// Creates a popover layout render object.
  PopoverLayoutRender({RenderBox? child, required this._alignment, required this._position, required this._anchorAlignment, required this._widthConstraint, required this._heightConstraint, this._anchorSize, this._offset, this._margin = const EdgeInsets.all(8), required this._scale, required this._scaleAlignment, this._filterQuality, this._allowInvertHorizontal = true, this._allowInvertVertical = true});
  /// Applies a new widget configuration, relayouting when anything changed.
  void updateConfiguration({required Alignment alignment, required Offset? position, required Alignment anchorAlignment, required PopoverConstraint widthConstraint, required PopoverConstraint heightConstraint, required Size? anchorSize, required Offset? offset, required EdgeInsets margin, required double scale, required Alignment scaleAlignment, required FilterQuality? filterQuality, required bool allowInvertHorizontal, required bool allowInvertVertical});
  Size computeDryLayout(covariant BoxConstraints constraints);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  void applyPaintTransform(RenderBox child, Matrix4 transform);
  bool get alwaysNeedsCompositing;
  void paint(PaintingContext context, Offset offset);
  /// Constraints applied to the popover child.
  BoxConstraints getConstraintsForChild(BoxConstraints constraints);
  void performLayout();
}
```
