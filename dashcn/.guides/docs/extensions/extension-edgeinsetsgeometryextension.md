---
title: "Extension: EdgeInsetsGeometryExtension"
description: "Resolves the geometry against the ambient [Directionality] only when  needed."
---

```dart
/// Resolves the geometry against the ambient [Directionality] only when
/// needed.
extension EdgeInsetsGeometryExtension on EdgeInsetsGeometry {
  /// Returns these insets as an [EdgeInsets].
  EdgeInsets optionallyResolve(BuildContext context);
}
```
