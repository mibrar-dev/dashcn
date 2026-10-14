---
title: "Class: HSLColorSliderPainter"
description: "Painter for [HSLColorSlider]; the gradient comes from the shared engine in  `primitives/color_field_paint."
---

```dart
/// Painter for [HSLColorSlider]; the gradient comes from the shared engine in
/// `primitives/color_field_paint.dart`.
class HSLColorSliderPainter extends CustomPainter {
  /// Creates the painter.
  const HSLColorSliderPainter({required this.color, required this.hueAxis, required this.saturationAxis, required this.lightnessAxis, required this.alphaAxis});
  /// The colour the gradient is derived from; the alpha channel passes
  /// through only when [alphaAxis] varies.
  final HSLColor color;
  /// Axis the hue varies along.
  final ColorFieldAxis hueAxis;
  /// Axis the saturation varies along.
  final ColorFieldAxis saturationAxis;
  /// Axis the lightness varies along.
  final ColorFieldAxis lightnessAxis;
  /// Axis the alpha varies along.
  final ColorFieldAxis alphaAxis;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant HSLColorSliderPainter oldDelegate);
}
```
