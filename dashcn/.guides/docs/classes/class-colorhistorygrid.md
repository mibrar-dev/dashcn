---
title: "Class: ColorHistoryGrid"
description: "Grid view over a [ColorHistoryStorage]."
---

```dart
/// Grid view over a [ColorHistoryStorage].
class ColorHistoryGrid extends StatelessWidget {
  /// Creates the grid.
  const ColorHistoryGrid({super.key, required this.storage, this.onColorPicked, this.spacing, this.crossAxisCount = 10, this.selectedColor, this.maxTotalColors, this.theme});
  /// Backing storage.
  final ColorHistoryStorage storage;
  /// Called when a swatch is tapped.
  final ValueChanged<Color>? onColorPicked;
  /// Gap between swatches; null uses the theme default.
  final double? spacing;
  /// Swatches per row.
  final int crossAxisCount;
  /// Colour highlighted with the selection ring.
  final Color? selectedColor;
  /// Caps the number of rendered slots.
  final int? maxTotalColors;
  /// Widget-leg theme override.
  final HistoryTheme? theme;
  Widget build(BuildContext context);
}
```
