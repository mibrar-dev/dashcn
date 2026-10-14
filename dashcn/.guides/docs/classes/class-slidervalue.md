---
title: "Class: SliderValue"
description: "A single-thumb or range slider value."
---

```dart
/// A single-thumb or range slider value.
class SliderValue {
  /// Creates a single-thumb value.
  const SliderValue.single(double value);
  /// Creates a ranged value.
  const SliderValue.ranged(double start, double end);
  /// Whether this value has two thumbs.
  bool get isRanged;
  /// Range start (equals [end] for single values).
  double get start;
  /// Range end (the single value for single-thumb values).
  double get end;
  /// Alias of [end].
  double get value;
  /// Lerps two values; range/single mismatches return null.
  static SliderValue? lerp(SliderValue? a, SliderValue? b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
