---
title: "Class: GooeyShapeLayer"
description: "One gooey surface layer: optional backdrop blur behind the composited  shape layers."
---

```dart
/// One gooey surface layer: optional backdrop blur behind the composited
/// shape layers.
class GooeyShapeLayer extends StatelessWidget {
  /// Creates a shape layer.
  const GooeyShapeLayer({super.key, required this.width, required this.height, required this.geometry, required this.color, this.fillAlpha = 1, this.blur = 0, this.surfaceBlur = 0, this.enableGooeyBlur = true, this.borderColor, this.shadowColor});
  /// Canvas width.
  final double width;
  /// Canvas height.
  final double height;
  /// Silhouette geometry for the current animation frame.
  final GooeyShapeGeometry geometry;
  /// Opaque surface colour.
  final Color color;
  /// Whole-layer opacity; `1` paints fully opaque.
  final double fillAlpha;
  /// Blur sigma of the metaball pass; `0` skips it.
  final double blur;
  /// Backdrop blur sigma clipped to the silhouette; `0` skips it.
  final double surfaceBlur;
  /// Whether the metaball pass runs at all.
  final bool enableGooeyBlur;
  /// Border colour around the silhouette; null skips the border.
  final Color? borderColor;
  /// Drop shadow colour under the silhouette; null skips the shadow.
  final Color? shadowColor;
  Widget build(BuildContext context);
}
```
