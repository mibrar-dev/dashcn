---
title: "Class: AxisInsetsGeometry"
description: "Base class for axis-based insets (start/end) that resolve to concrete  values based on [TextDirection]."
---

```dart
/// Base class for axis-based insets (start/end) that resolve to concrete
/// values based on [TextDirection].
abstract class AxisInsetsGeometry {
  const AxisInsetsGeometry();
  /// Resolves the insets to a concrete [AxisInsets].
  AxisInsets resolve(TextDirection textDirection);
}
```
