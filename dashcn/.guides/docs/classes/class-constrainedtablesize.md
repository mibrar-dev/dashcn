---
title: "Class: ConstrainedTableSize"
description: "Minimum and maximum extent for a resizable column or row."
---

```dart
/// Minimum and maximum extent for a resizable column or row.
class ConstrainedTableSize {
  /// Creates constraints; the defaults are unbounded.
  const ConstrainedTableSize({this.min = double.negativeInfinity, this.max = double.infinity});
  /// Minimum extent.
  final double min;
  /// Maximum extent.
  final double max;
}
```
