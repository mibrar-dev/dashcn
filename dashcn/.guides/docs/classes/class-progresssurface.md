---
title: "Class: ProgressSurface"
description: "Resolved visual values for one progress build."
---

```dart
/// Resolved visual values for one progress build.
class ProgressSurface {
  /// Creates a resolved surface.
  const ProgressSurface({required this.color, required this.backgroundColor, required this.height, required this.borderRadius, required this.showSparks, required this.animate});
  /// Fill colour.
  final Color color;
  /// Track colour.
  final Color backgroundColor;
  /// Bar height.
  final double height;
  /// Corner radius.
  final BorderRadiusGeometry borderRadius;
  /// Whether the leading-edge glow is painted.
  final bool showSparks;
  /// Whether value changes animate.
  final bool animate;
}
```
