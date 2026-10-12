---
title: "Class: PixelGridPainter"
description: "Paints an [ScreenSample]-shaped grid of colours as a circular magnified  preview, with a highlight around the centre cell."
---

```dart
/// Paints an [ScreenSample]-shaped grid of colours as a circular magnified
/// preview, with a highlight around the centre cell.
class PixelGridPainter extends CustomPainter {
  /// Creates a magnified-grid painter.
  const PixelGridPainter({required this.colors, required this.gridSize, required this.borderColor, required this.borderWidth, required this.selectedBorderColor, required this.selectedBorderWidth, required this.backgroundColor});
  /// The grid colours, row by row.
  final List<Color> colors;
  /// The grid size, in cells.
  final Size gridSize;
  /// Outer ring colour.
  final Color borderColor;
  /// Outer ring width.
  final double borderWidth;
  /// Centre-cell highlight colour.
  final Color selectedBorderColor;
  /// Centre-cell highlight width.
  final double selectedBorderWidth;
  /// Backing colour drawn behind the cells.
  final Color backgroundColor;
  void paint(Canvas canvas, Size size);
  bool shouldRepaint(covariant PixelGridPainter oldDelegate);
}
```
