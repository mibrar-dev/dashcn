---
title: "Class: FixedSheetStage"
description: "Stage pinned at a fixed pixel offset."
---

```dart
/// Stage pinned at a fixed pixel offset.
class FixedSheetStage extends SheetStage {
  /// Creates a fixed stage.
  const FixedSheetStage(this.offset, {this.backdropTransform});
  /// Pixels from the closed edge.
  final double offset;
  /// Explicit backdrop value; null falls back to normalized expansion.
  final double? backdropTransform;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
