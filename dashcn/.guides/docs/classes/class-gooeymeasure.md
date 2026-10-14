---
title: "Class: GooeyMeasure"
description: "Reports its child's laid-out size after each layout pass."
---

```dart
/// Reports its child's laid-out size after each layout pass.
class GooeyMeasure extends SingleChildRenderObjectWidget {
  /// Creates a measure widget.
  const GooeyMeasure({super.key, required this.onSizeChanged, required super.child});
  /// Called with the new size when it changes between layout passes.
  final ValueChanged<Size> onSizeChanged;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderObject renderObject);
}
```
