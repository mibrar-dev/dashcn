---
title: "Class: MarqueeSurface"
description: "Resolved geometry for one marquee build."
---

```dart
/// Resolved geometry for one marquee build.
class MarqueeSurface {
  /// Creates a resolved surface.
  const MarqueeSurface({required this.direction, required this.duration, required this.delayDuration, required this.step, required this.fadePortion, required this.curve, required this.fadeColor});
  /// Scroll axis.
  final Axis direction;
  /// Time of one `step` run.
  final Duration duration;
  /// Pause at each end.
  final Duration delayDuration;
  /// Pixels per [duration].
  final double step;
  /// Edge fade as a fraction of the visible extent.
  final double fadePortion;
  /// Easing of each run.
  final Curve curve;
  /// Colour the edge fade blends into; the ambient `background` token, so the
  /// fade tracks the selected preset in light and dark.
  final Color fadeColor;
}
```
