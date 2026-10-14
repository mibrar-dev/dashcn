---
title: "Class: Group"
description: "A layout surface that places children at explicit offsets and sizes."
---

```dart
/// A layout surface that places children at explicit offsets and sizes.
///
/// Every child should be a [GroupPositioned]. A child without one fills the
/// available space (or takes its natural size when the group is unbounded).
class Group extends MultiChildRenderObjectWidget {
  /// Creates a group.
  const Group({super.key, super.children});
  RenderGroup createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderGroup renderObject);
}
```
