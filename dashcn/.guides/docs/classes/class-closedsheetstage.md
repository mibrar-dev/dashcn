---
title: "Class: ClosedSheetStage"
description: "Fully hidden stage."
---

```dart
/// Fully hidden stage.
class ClosedSheetStage extends SheetStage {
  /// Creates a closed stage.
  const ClosedSheetStage({this.backdropTransform});
  /// Explicit backdrop value; null falls back to normalized expansion.
  final double? backdropTransform;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
