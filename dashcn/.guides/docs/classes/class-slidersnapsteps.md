---
title: "Class: SliderSnapSteps"
description: "Evenly spaced snapping."
---

```dart
/// Evenly spaced snapping.
class SliderSnapSteps extends SliderSnap {
  /// Creates a step strategy; [steps] must be positive.
  const SliderSnapSteps(this.steps);
  /// Number of intervals across the domain.
  final int steps;
}
```
