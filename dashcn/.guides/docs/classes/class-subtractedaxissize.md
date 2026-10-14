---
title: "Class: SubtractedAxisSize"
description: "Difference of two [AxisSize]s."
---

```dart
/// Difference of two [AxisSize]s.
class SubtractedAxisSize extends AxisSize {
  /// Creates a subtracted axis size.
  const SubtractedAxisSize(this.a, this.b);
  /// The left operand.
  final AxisSize a;
  /// The right operand.
  final AxisSize b;
  double resolve(double available);
}
```
