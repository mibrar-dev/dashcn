---
title: "Class: ExpandedSheetStage"
description: "Fully shown stage."
---

```dart
/// Fully shown stage.
class ExpandedSheetStage extends SheetStage {
  /// Creates an expanded stage.
  const ExpandedSheetStage({this.backdropTransform});
  /// Explicit backdrop value; null falls back to normalized expansion.
  final double? backdropTransform;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
