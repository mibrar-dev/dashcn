---
title: "Class: AdditiveSheetStage"
description: "Sum of two stages."
---

```dart
/// Sum of two stages.
class AdditiveSheetStage extends SheetStage {
  /// Creates an additive stage.
  const AdditiveSheetStage(this.a, this.b);
  /// Left operand.
  final SheetStage a;
  /// Right operand.
  final SheetStage b;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
