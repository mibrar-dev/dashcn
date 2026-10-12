---
title: "Extension: BorderRadiusGeometryExtension"
description: "Resolves the geometry against the ambient [Directionality] only when  needed."
---

```dart
/// Resolves the geometry against the ambient [Directionality] only when
/// needed.
extension BorderRadiusGeometryExtension on BorderRadiusGeometry {
  /// Returns this radius as a [BorderRadius].
  BorderRadius optionallyResolve(BuildContext context);
}
```
