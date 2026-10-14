---
title: "Class: SliderThumb"
description: "Placement of a single thumb inside the slider canvas."
---

```dart
/// Placement of a single thumb inside the slider canvas.
class SliderThumb {
  /// Creates a thumb placement.
  const SliderThumb({required this.index, required this.value, required this.t, required this.center, required this.size, required this.active, required this.enabled});
  /// Thumb index (`0` = single value or range start, `1` = range end).
  final int index;
  /// Resolved value at this thumb.
  final double value;
  /// Normalized position in `[0, 1]`.
  final double t;
  /// Center in canvas coordinates.
  final Offset center;
  /// Layout size of the thumb.
  final Size size;
  /// Whether this thumb is being dragged.
  final bool active;
  /// Whether interaction is enabled.
  final bool enabled;
}
```
