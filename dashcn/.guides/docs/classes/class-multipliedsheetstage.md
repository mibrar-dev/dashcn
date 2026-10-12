---
title: "Class: MultipliedSheetStage"
description: "Stage scaled by [factor]."
---

```dart
/// Stage scaled by [factor].
class MultipliedSheetStage extends SheetStage {
  /// Creates a multiplied stage.
  const MultipliedSheetStage(this.stage, this.factor);
  /// Operand.
  final SheetStage stage;
  /// Scalar factor.
  final double factor;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
