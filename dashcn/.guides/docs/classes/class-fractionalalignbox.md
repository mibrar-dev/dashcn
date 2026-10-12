---
title: "Class: FractionalAlignBox"
description: "Constrains the child to a share of the available width and aligns it."
---

```dart
/// Constrains the child to a share of the available width and aligns it.
///
/// ```dart
/// FractionalAlignBox(
///   factor: 0.5,
///   alignment: AlignmentDirectional.centerEnd.resolve(textDirection),
///   child: const Text('at most half as wide as the row'),
/// )
/// ```
class FractionalAlignBox extends SingleChildRenderObjectWidget {
  /// Creates a fraction-limited, aligned box.
  const FractionalAlignBox({super.key, required this.factor, required this.alignment, required super.child});
  /// Share of the incoming width the child may use (`0..1`). A non-finite
  /// incoming width (unbounded rows) ignores the factor.
  final double factor;
  /// Where the child sits inside the box; resolved against the ambient
  /// direction.
  final AlignmentGeometry alignment;
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, FractionalAlignBoxRender renderObject);
}
```
