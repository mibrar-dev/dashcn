---
title: "Class: SubtractedSheetStage"
description: "Difference of two stages."
---

```dart
/// Difference of two stages.
class SubtractedSheetStage extends SheetStage {
  /// Creates a subtracted stage.
  const SubtractedSheetStage(this.a, this.b);
  /// Left operand.
  final SheetStage a;
  /// Right operand.
  final SheetStage b;
  double resolveDragOffset(SheetStageResolution resolution);
  double resolveBackdropTransform(SheetStageResolution resolution);
}
```
