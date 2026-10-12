---
title: "Class: GroupParentData"
description: "Parent data carrying one child's explicit placement inside a [Group]."
---

```dart
/// Parent data carrying one child's explicit placement inside a [Group].
class GroupParentData extends ContainerBoxParentData<RenderBox> {
  /// Distance from the group's top edge, when pinned.
  double? top;
  /// Distance from the group's leading (left) edge, when pinned.
  double? left;
  /// Distance from the group's trailing (right) edge, when pinned.
  double? right;
  /// Distance from the group's bottom edge, when pinned.
  double? bottom;
  /// Fixed width, when given.
  double? width;
  /// Fixed height, when given.
  double? height;
}
```
