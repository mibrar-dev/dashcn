---
title: "Class: GooeyShapePainter"
description: "Paints the single-contour gooey silhouette: an optional token-coloured  drop shadow, the opaque fill, and an optional 1px token border."
---

```dart
/// Paints the single-contour gooey silhouette: an optional token-coloured
/// drop shadow, the opaque fill, and an optional 1px token border.
///
/// The border is stroked once around the merged contour — never per shape —
/// so it cannot double up at the pill/body junction. The open morph is
/// carried by the geometry (width/fillets/height), not by fading shapes.
class GooeyShapePainter extends CustomPainter {
  /// Creates a painter for [geometry] in [color].
  const GooeyShapePainter({required this.color, required this.geometry, this.borderColor, this.shadowColor, this.elevation = kGooeyShadowElevation});
  /// Opaque surface colour; per-frame alpha is carried by the layer.
  final Color color;
  /// Silhouette to paint.
  final GooeyShapeGeometry geometry;
  /// Border colour stroked once around the merged silhouette; null skips it.
  final Color? borderColor;
  /// Drop shadow colour under the merged silhouette; null skips it.
  final Color? shadowColor;
  /// Material-style elevation of the drop shadow.
  final double elevation;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(GooeyShapePainter oldDelegate);
}
```
