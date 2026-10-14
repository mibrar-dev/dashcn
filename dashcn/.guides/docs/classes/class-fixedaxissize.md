---
title: "Class: FixedAxisSize"
description: "A fixed number of logical pixels."
---

```dart
/// A fixed number of logical pixels.
class FixedAxisSize extends AxisSize {
  /// Creates a fixed axis size.
  const FixedAxisSize(this.size);
  /// The size in logical pixels.
  final double size;
  double resolve(double available);
}
```
