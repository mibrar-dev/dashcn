---
title: "Class: SheetStageResolution"
description: "The context a [SheetStage] resolves against."
---

```dart
/// The context a [SheetStage] resolves against.
class SheetStageResolution {
  /// Creates a resolution context.
  const SheetStageResolution({required this.size, required this.position, this.dragHandleExtent = 0});
  /// Measured sheet content size.
  final Size size;
  /// Resolved edge position (never start/end).
  final OverlayPosition position;
  /// Main-axis pixels of the drag handle (+ gaps); 0 without a handle.
  final double dragHandleExtent;
  /// Sheet extent along its drag axis.
  double get axisExtent;
}
```
