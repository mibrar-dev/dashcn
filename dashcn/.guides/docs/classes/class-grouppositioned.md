---
title: "Class: GroupPositioned"
description: "Places a child inside a [Group] at explicit coordinates."
---

```dart
/// Places a child inside a [Group] at explicit coordinates.
class GroupPositioned extends ParentDataWidget<GroupParentData> {
  /// Creates a positioned child.
  const GroupPositioned({super.key, this.top, this.left, this.right, this.bottom, this.width, this.height, required super.child});
  /// Creates a child that fills the group bounds.
  const GroupPositioned.fill({super.key, this.top = 0, this.left = 0, this.right = 0, this.bottom = 0, this.width, this.height, required super.child});
  /// Creates a child from [rect].
  GroupPositioned.fromRect({super.key, required Rect rect, required super.child});
  /// Distance from the group's top edge, when pinned.
  final double? top;
  /// Distance from the group's leading (left) edge, when pinned.
  final double? left;
  /// Distance from the group's trailing (right) edge, when pinned.
  final double? right;
  /// Distance from the group's bottom edge, when pinned.
  final double? bottom;
  /// Fixed width, when given.
  final double? width;
  /// Fixed height, when given.
  final double? height;
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
