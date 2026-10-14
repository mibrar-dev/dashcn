---
title: "Class: PeekDragHandleSheetStage"
description: "Stage peeking only the drag handle."
---

```dart
/// Stage peeking only the drag handle.
class PeekDragHandleSheetStage extends SheetStage {
  /// Creates a peek stage.
  const PeekDragHandleSheetStage({this.backdropTransform});
  /// Explicit backdrop value; null falls back to normalized expansion.
  final double? backdropTransform;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
