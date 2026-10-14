---
title: "Class: StepperStep"
description: "One step of a [Stepper]."
---

```dart
/// One step of a [Stepper].
class StepperStep {
  /// Creates a step.
  const StepperStep({required this.title, this.content, this.icon});
  /// Step label.
  final Widget title;
  /// Content shown while this step is active.
  final Widget? content;
  /// Replaces the number inside the indicator.
  final Widget? icon;
}
```
