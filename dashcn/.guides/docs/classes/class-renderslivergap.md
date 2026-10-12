---
title: "Class: RenderSliverGap"
description: "Render object behind [SliverGap]."
---

```dart
/// Render object behind [SliverGap].
class RenderSliverGap extends RenderSliver {
  RenderSliverGap({required this._mainAxisExtent, this._color});
  double get mainAxisExtent;
  set mainAxisExtent(double value);
  Color? get color;
  set color(Color? value);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```
