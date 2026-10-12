---
title: "Class: AlphaPainter"
description: "A checkerboard painter used to visualize transparency."
---

```dart
/// A checkerboard painter used to visualize transparency.
///
/// The pattern is shown behind semi-transparent colors in color pickers or
/// image editors to make the alpha level readable on any background. Wrap in
/// a `CustomPaint` sized to the area being visualized.
class AlphaPainter extends CustomPainter {
  /// Creates a checkerboard painter.
  const AlphaPainter({this.primary = checkboardPrimary, this.secondary = checkboardSecondary, this.squareSize = checkboardSize});
  /// Primary color used in the checkerboard pattern.
  static const Color checkboardPrimary = Color(0xFFE0E0E0);
  /// Secondary color used in the checkerboard pattern.
  static const Color checkboardSecondary = Color(0xFFB0B0B0);
  /// Size of each square in the checkerboard pattern.
  static const double checkboardSize = 8.0;
  /// Fill color of the even squares.
  final Color primary;
  /// Fill color of the odd squares.
  final Color secondary;
  /// Edge length of one square.
  final double squareSize;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant AlphaPainter oldDelegate);
}
```
