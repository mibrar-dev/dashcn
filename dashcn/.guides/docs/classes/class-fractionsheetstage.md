---
title: "Class: FractionSheetStage"
description: "Stage pinned at a fraction of the axis extent."
---

```dart
/// Stage pinned at a fraction of the axis extent.
class FractionSheetStage extends SheetStage {
  /// Creates a fractional stage.
  const FractionSheetStage(this.fraction, {this.backdropTransform});
  /// Fraction (0..1) of the axis extent.
  final double fraction;
  /// Explicit backdrop value; null falls back to normalized expansion.
  final double? backdropTransform;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
