---
title: "Class: AxisAlignmentGeometry"
description: "Base class for axis alignments that resolve based on [TextDirection]."
---

```dart
/// Base class for axis alignments that resolve based on [TextDirection].
abstract class AxisAlignmentGeometry {
  const AxisAlignmentGeometry();
  /// Resolves this alignment to a concrete [AxisAlignment] for a text
  /// direction.
  AxisAlignment resolve(TextDirection textDirection);
}
```
