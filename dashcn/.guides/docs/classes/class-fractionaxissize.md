---
title: "Class: FractionAxisSize"
description: "A fraction (0."
---

```dart
/// A fraction (0..1) of the available extent.
class FractionAxisSize extends AxisSize {
  /// Creates a fractional axis size.
  const FractionAxisSize(this.fraction);
  /// The fraction of the available extent.
  final double fraction;
  double resolve(double available);
}
```
