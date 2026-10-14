---
title: "Class: DividedAxisSize"
description: "An [AxisSize] divided by a scalar factor."
---

```dart
/// An [AxisSize] divided by a scalar factor.
class DividedAxisSize extends AxisSize {
  /// Creates a divided axis size.
  const DividedAxisSize(this.size, this.factor);
  /// The operand.
  final AxisSize size;
  /// The scalar divisor.
  final double factor;
  double resolve(double available);
}
```
