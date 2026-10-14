---
title: "Class: BorderTracerSpec"
description: "Tracer segment settings for [BorderLoadingMode."
---

```dart
/// Tracer segment settings for [BorderLoadingMode.tracer].
class BorderTracerSpec {
  /// Creates tracer settings for moving dash segments.
  const BorderTracerSpec({this.lengthFraction = 0.18, this.gapFraction = 0.10, this.dashCount = 1, this.roundCaps = true});
  /// Segment length as a fraction of the total perimeter.
  final double lengthFraction;
  /// Gap fraction clamping each segment inside its lane.
  final double gapFraction;
  /// Number of equally spaced tracer segments.
  final int dashCount;
  /// Whether segment ends should be rounded.
  final bool roundCaps;
}
```
