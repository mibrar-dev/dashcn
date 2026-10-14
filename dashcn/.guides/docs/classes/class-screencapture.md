---
title: "Class: ScreenCapture"
description: "A frozen capture of a render boundary: the decoded image plus its colors."
---

```dart
/// A frozen capture of a render boundary: the decoded image plus its colors.
///
/// Call [dispose] when the capture is no longer needed; it releases the
/// underlying [image].
class ScreenCapture {
  /// Creates a capture from an already-decoded image and colour buffer.
  const ScreenCapture({required this.image, required this.colors, required this.size});
  /// The decoded screenshot, for `RawImage`/`CustomPaint`.
  final ui.Image image;
  /// The same pixels, row by row in ARGB order.
  final List<Color> colors;
  /// The size of the capture, in source pixels.
  final Size size;
  /// The colour at the source pixel `(x, y)`.
  Color colorAt(int x, int y);
  /// Samples a [gridSize] grid of pixels centred on [position].
  ///
  /// Pixels outside the capture become fully transparent and the grid is
  /// capped at 512x512 so a degenerate zoom cannot allocate unboundedly.
  ScreenSample sample(Offset position, Size gridSize);
  /// Releases the decoded image.
  void dispose();
}
```
