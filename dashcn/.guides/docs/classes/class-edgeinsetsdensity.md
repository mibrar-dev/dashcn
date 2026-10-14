---
title: "Class: EdgeInsetsDensity"
description: "Padding with density multipliers."
---

```dart
/// Padding with density multipliers.
class EdgeInsetsDensity extends EdgeInsets implements DensityEdgeInsetsGeometry {
  const EdgeInsetsDensity.only({super.left = 0.0, super.top = 0.0, super.right = 0.0, super.bottom = 0.0});
  const EdgeInsetsDensity.all(super.value);
  const EdgeInsetsDensity.symmetric({super.vertical = 0.0, super.horizontal = 0.0});
  /// Padding whose sides are upstream px values at the default density.
  ///
  /// `EdgeInsetsDensity.pxSymmetric(horizontal: 8, vertical: 2)` is upstream
  /// `px-2 py-0.5`: every side resolves to `px * base / 16`, so at
  /// [Density.defaultDensity] the padding measures exactly the upstream value
  /// and every other density scales it by [Density.scale] — the rule the
  /// `button` size table spells out per size.
  const EdgeInsetsDensity.pxSymmetric({double horizontal = 0, double vertical = 0});
  /// `EdgeInsets.all` in upstream px at the default density.
  const EdgeInsetsDensity.pxAll(double px);
  EdgeInsets resolveDensity(double basePadding);
}
```
