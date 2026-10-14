---
title: "Class: DirectionalEdgeInsetsDensity"
description: "Directional padding with density multipliers."
---

```dart
/// Directional padding with density multipliers.
class DirectionalEdgeInsetsDensity extends EdgeInsetsDirectional implements DensityEdgeInsetsGeometry {
  const DirectionalEdgeInsetsDensity.only({super.start = 0.0, super.top = 0.0, super.end = 0.0, super.bottom = 0.0});
  const DirectionalEdgeInsetsDensity.all(super.value);
  const DirectionalEdgeInsetsDensity.symmetric({super.vertical = 0.0, super.horizontal = 0.0});
  EdgeInsetsDirectional resolveDensity(double basePadding);
}
```
