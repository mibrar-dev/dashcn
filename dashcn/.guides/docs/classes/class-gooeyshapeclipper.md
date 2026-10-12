---
title: "Class: GooeyShapeClipper"
description: "Clips the backdrop blur to the gooey silhouette."
---

```dart
/// Clips the backdrop blur to the gooey silhouette.
class GooeyShapeClipper extends CustomClipper<Path> {
  /// Creates a clipper over [geometry].
  const GooeyShapeClipper(this.geometry);
  /// Silhouette to clip to.
  final GooeyShapeGeometry geometry;
  Path getClip(Size size);
  bool shouldReclip(GooeyShapeClipper oldClipper);
}
```
