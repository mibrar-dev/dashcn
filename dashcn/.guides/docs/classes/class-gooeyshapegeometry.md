---
title: "Class: GooeyShapeGeometry"
description: "Silhouette of one gooey surface for a single animation frame."
---

```dart
/// Silhouette of one gooey surface for a single animation frame.
class GooeyShapeGeometry {
  /// Creates a geometry snapshot.
  const GooeyShapeGeometry({this.roundness = 18, this.pillX = 0, this.pillWidth = 350, this.pillHeight = 40, this.pillCanvasHeight = 40, this.pillScaleY = 1, this.bodyHeight = 0, this.bodyScaleY = 0});
  /// Corner roundness of the pill, fillets and body (already shape-resolved).
  final double roundness;
  /// Left edge of the compact pill inside the surface canvas.
  final double pillX;
  /// Width of the compact pill.
  final double pillWidth;
  /// Content height of the pill; also the seam the body grows from.
  final double pillHeight;
  /// Drawn pill height including the blur head-room, before [pillScaleY].
  final double pillCanvasHeight;
  /// Vertical scale of the drawn pill: content/padded while closed, `1` open.
  final double pillScaleY;
  /// Height of the expanded body; `0` keeps the surface closed.
  final double bodyHeight;
  /// Opening progress of the expanded body (`0..1`).
  final double bodyScaleY;
  /// Merged metaball silhouette: the pill, body and shoulder ovals unioned.
  Path buildSilhouette(Size size);
  bool operator ==(Object other);
  int get hashCode;
}
```
