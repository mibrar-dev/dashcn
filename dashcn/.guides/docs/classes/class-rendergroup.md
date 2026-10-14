---
title: "Class: RenderGroup"
description: "Render object that lays out [Group] children at absolute offsets."
---

```dart
/// Render object that lays out [Group] children at absolute offsets.
class RenderGroup extends RenderBox with ContainerRenderObjectMixin<RenderBox, GroupParentData>, RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  void setupParentData(RenderBox child);
  void performLayout();
  Size computeDryLayout(BoxConstraints constraints);
  void paint(PaintingContext context, Offset offset);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
