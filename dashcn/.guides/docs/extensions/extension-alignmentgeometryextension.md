---
title: "Extension: AlignmentGeometryExtension"
description: "Resolves the geometry against the ambient [Directionality] only when  needed."
---

```dart
/// Resolves the geometry against the ambient [Directionality] only when
/// needed.
extension AlignmentGeometryExtension on AlignmentGeometry {
  /// Returns this alignment as an [Alignment].
  Alignment optionallyResolve(BuildContext context);
}
```
