---
title: "Class: SliderPainter"
description: "Paints track, fill, variant marks and thumbs."
---

```dart
/// Paints track, fill, variant marks and thumbs. Replaces the old Material
/// `Slider` render path; the whole control is `CustomPaint`, no Material.
class SliderPainter extends CustomPainter {
  const SliderPainter({required this.view, required this.marksStyle, required this.thumbShape, required this.trackColor, required this.fillColor, required this.thumbColor, required this.thumbBorderColor, required this.markColor, required this.focused, required this.ringColor});
  final SliderView view;
  final SliderMarksStyle marksStyle;
  final SliderThumbShape thumbShape;
  final Color trackColor;
  final Color fillColor;
  final Color thumbColor;
  final Color thumbBorderColor;
  final Color markColor;
  final bool focused;
  final Color ringColor;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant SliderPainter oldDelegate);
}
```
