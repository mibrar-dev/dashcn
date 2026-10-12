---
title: "Class: RenderGap"
description: "Render object behind [Gap]."
---

```dart
/// Render object behind [Gap].
class RenderGap extends RenderBox {
  RenderGap({required this._mainAxisExtent, this._crossAxisExtent, this._fallbackDirection, this._color});
  double get mainAxisExtent;
  set mainAxisExtent(double value);
  double? get crossAxisExtent;
  set crossAxisExtent(double? value);
  /// The axis to use when the parent is not a [RenderFlex].
  Axis? get fallbackDirection;
  set fallbackDirection(Axis? value);
  Color? get color;
  set color(Color? value);
  double computeMinIntrinsicWidth(double height);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  Size computeDryLayout(BoxConstraints constraints);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
