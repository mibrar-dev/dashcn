---
title: "Class: DensityEdgeInsetsGeometry"
description: "Padding whose multipliers resolve against a density base at build."
---

```dart
/// Padding whose multipliers resolve against a density base at build.
abstract class DensityEdgeInsetsGeometry extends EdgeInsetsGeometry {
  /// Resolves multipliers against [basePadding].
  EdgeInsetsGeometry resolveDensity(double basePadding);
}
```
