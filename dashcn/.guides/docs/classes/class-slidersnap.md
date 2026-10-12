---
title: "Class: SliderSnap"
description: "How tap/drag output values are quantized."
---

```dart
/// How tap/drag output values are quantized.
class SliderSnap {
  const SliderSnap();
  /// Continuous values; clamped only.
  factory SliderSnap.none();
  /// Evenly spaced intervals across `[min, max]`.
  factory SliderSnap.steps(int steps);
  /// Nearest entry of an explicit value list.
  factory SliderSnap.values(List<double> values);
  /// Quantizes [v] for [min]..[max].
  double apply(double v, double min, double max);
  /// Marks to paint for this snap strategy.
  List<SliderMark> marks(double min, double max);
}
```
