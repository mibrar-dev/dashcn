---
title: "Class: AxisInsets"
description: "Insets along an axis with support for directionality."
---

```dart
/// Insets along an axis with support for directionality.
class AxisInsets extends AxisInsetsGeometry {
  /// The resolved text direction, if any.
  final TextDirection? direction;
  /// The start value.
  final double start;
  /// The end value.
  final double end;
  const AxisInsets({required this.start, required this.end});
  /// Resolves the start and end values for [axis].
  ({double start, double end}) resolveValue(Axis axis);
  AxisInsets resolve(TextDirection textDirection);
}
```
