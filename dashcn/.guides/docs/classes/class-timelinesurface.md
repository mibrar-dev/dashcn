---
title: "Class: TimelineSurface"
description: "Resolved geometry for one timeline build."
---

```dart
/// Resolved geometry for one timeline build.
class TimelineSurface {
  /// Creates a resolved surface.
  const TimelineSurface({required this.timeConstraints, required this.spacing, required this.dotSize, required this.connectorThickness, required this.color, required this.rowGap, required this.contentStart, required this.colors});
  /// Width of the time column.
  final BoxConstraints timeConstraints;
  /// Gap between the three columns.
  final double spacing;
  /// Dot diameter.
  final double dotSize;
  /// Connector thickness.
  final double connectorThickness;
  /// Dot/connector colour when the entry carries none.
  final Color color;
  /// Gap between rows.
  final double rowGap;
  /// Left inset of the title/content column.
  final double contentStart;
  /// Ambient colour tokens, used to resolve per-entry colours.
  final ThemeColors colors;
  /// The colour an entry with [entryColor] paints its indicator/connector in.
  Color indicatorFor(ThemedColor? entryColor);
}
```
