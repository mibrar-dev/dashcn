---
title: "Class: ResizablePaneHandle"
description: "A pane's constraints plus controller, managed by a group."
---

```dart
/// A pane's constraints plus controller, managed by a group.
class ResizablePaneHandle {
  /// Creates a pane handle.
  ResizablePaneHandle({required this.controller, this.minSize, this.maxSize, this.collapsedSize});
  /// The pane controller.
  ResizablePaneController controller;
  /// Minimum size in pixels.
  double? minSize;
  /// Maximum size in pixels.
  double? maxSize;
  /// Size when collapsed.
  double? collapsedSize;
  /// The pane's current size for [paneSize], honouring the constraints.
  double computeSize(double paneSize);
}
```
