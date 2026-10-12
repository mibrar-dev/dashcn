---
title: "Class: ResizableEntryItem"
description: "A [ResizableItem] that remembers its controller."
---

```dart
/// A [ResizableItem] that remembers its controller.
class ResizableEntryItem extends ResizableItem {
  /// Creates an entry item.
  ResizableEntryItem({required super.value, super.min, super.max, super.collapsed, super.collapsedSize, required this.controller});
  /// The controller this item resizes.
  final ResizablePaneController controller;
}
```
