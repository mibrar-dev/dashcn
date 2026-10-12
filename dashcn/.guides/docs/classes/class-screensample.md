---
title: "Class: ScreenSample"
description: "A magnified grid of sampled pixels."
---

```dart
/// A magnified grid of sampled pixels.
class ScreenSample {
  /// Creates a sample.
  const ScreenSample(this.colors, this.size, this.pickedColor);
  /// The size of the sampled grid, in source pixels.
  final Size size;
  /// The sampled grid, stored row by row.
  final List<Color> colors;
  /// The colour at the centre of the grid.
  final Color pickedColor;
  /// The colour at [position], clamped to the grid.
  Color operator [](Offset position);
  bool operator ==(Object other);
  int get hashCode;
}
```
