---
title: "Class: SliderSnapValues"
description: "Nearest-value snapping."
---

```dart
/// Nearest-value snapping.
class SliderSnapValues extends SliderSnap {
  /// Creates a value-list strategy.
  const SliderSnapValues(this.values);
  /// Candidate values; an empty list falls back to clamping.
  final List<double> values;
}
```
