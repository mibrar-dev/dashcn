---
title: "Class: DividedSheetStage"
description: "Stage divided by [factor]."
---

```dart
/// Stage divided by [factor].
class DividedSheetStage extends SheetStage {
  /// Creates a divided stage.
  const DividedSheetStage(this.stage, this.factor);
  /// Operand.
  final SheetStage stage;
  /// Scalar divisor.
  final double factor;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
