---
title: "Class: FractionalTableSize"
description: "Sizes a column or row to a [fraction] of the table's extent."
---

```dart
/// Sizes a column or row to a [fraction] of the table's extent.
class FractionalTableSize extends TableSize {
  /// Creates a fractional size.
  const FractionalTableSize(this.fraction);
  /// Fraction of the bounded extent.
  final double fraction;
}
```
