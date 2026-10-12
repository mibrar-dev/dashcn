---
title: "Class: SurfaceBlur"
description: "A blur layer clipped to [borderRadius]."
---

```dart
/// A blur layer clipped to [borderRadius].
///
/// Rendered even at zero sigma so toggling [surfaceBlur] never remounts the
/// child subtree.
class SurfaceBlur extends StatelessWidget {
  /// Creates a blur layer.
  const SurfaceBlur({super.key, required this.child, required this.surfaceBlur, this.borderRadius});
  /// The child blurred against the backdrop.
  final Widget child;
  /// Blur sigma; values <= 0 draw an identity filter.
  final double surfaceBlur;
  /// Clip radius of the blur layer. Default: square corners.
  final BorderRadiusGeometry? borderRadius;
  Widget build(BuildContext context);
}
```
