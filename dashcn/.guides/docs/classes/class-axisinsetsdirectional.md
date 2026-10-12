---
title: "Class: AxisInsetsDirectional"
description: "Directional insets along an axis, resolved by [TextDirection]."
---

```dart
/// Directional insets along an axis, resolved by [TextDirection].
class AxisInsetsDirectional extends AxisInsetsGeometry {
  /// The start value.
  final double start;
  /// The end value.
  final double end;
  const AxisInsetsDirectional({required this.start, required this.end});
  AxisInsets resolve(TextDirection textDirection);
}
```
