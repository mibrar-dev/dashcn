---
title: "Class: AxisAlignment"
description: "Alignment along a single axis, compatible with [AxisAlignmentGeometry]."
---

```dart
/// Alignment along a single axis, compatible with [AxisAlignmentGeometry].
class AxisAlignment extends AxisAlignmentGeometry {
  static const AxisAlignment left = AxisAlignment(-1.0);
  static const AxisAlignment right = AxisAlignment(1.0);
  static const AxisAlignment center = AxisAlignment(0.0);
  /// The resolved text direction, if any.
  final TextDirection? direction;
  /// The alignment value in `-1.0..1.0`.
  final double value;
  const AxisAlignment(this.value);
  /// Returns the resolved alignment value for [axis].
  double resolveValue(Axis axis);
  /// Positions a child within a span of [size] using this alignment.
  double alongValue(Axis axis, double size);
  /// Converts this alignment to an [Alignment] for a horizontal layout.
  Alignment asHorizontalAlignment(AxisAlignment crossAxisAlignment);
  /// Converts this alignment to an [Alignment] for a vertical layout.
  Alignment asVerticalAlignment(AxisAlignment crossAxisAlignment);
  AxisAlignment resolve(TextDirection textDirection);
}
```
