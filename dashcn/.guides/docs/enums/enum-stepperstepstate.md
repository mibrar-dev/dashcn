---
title: "Enum: StepperStepState"
description: "Extra state a step carries on top of \"before / current / after\"."
---

```dart
/// Extra state a step carries on top of "before / current / after".
enum StepperStepState {
  /// The step failed validation: it and every later connector go destructive.
  failed,
}
```
