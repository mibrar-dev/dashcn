---
title: "Class: HSVColorSliderPainter"
description: "Painter for [HSVColorSlider]; the gradient comes from the shared engine in  `primitives/color_field_paint."
---

```dart
/// Painter for [HSVColorSlider]; the gradient comes from the shared engine in
/// `primitives/color_field_paint.dart`.
class HSVColorSliderPainter extends CustomPainter {
  /// Creates the painter.
  const HSVColorSliderPainter({required this.color, required this.hueAxis, required this.saturationAxis, required this.valueAxis, required this.alphaAxis});
  /// The colour the gradient is derived from; the alpha channel passes
  /// through only when [alphaAxis] varies.
  final HSVColor color;
  /// Axis the hue varies along.
  final ColorFieldAxis hueAxis;
  /// Axis the saturation varies along.
  final ColorFieldAxis saturationAxis;
  /// Axis the value varies along.
  final ColorFieldAxis valueAxis;
  /// Axis the alpha varies along.
  final ColorFieldAxis alphaAxis;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSVColorSliderPainter oldDelegate);
}
```
