---
title: "Class: GooeyCompactMorph"
description: "Timing and choreography of the compact pill morph."
---

```dart
/// Timing and choreography of the compact pill morph.
///
/// Changing a toast's title/state in place (the promise and multi-state flows)
/// cross-fades the outgoing compact frame out and the incoming one in instead
/// of snapping: the old label slides up while the new one rises from below, and
/// both scale from [scaleFrom] up to `1`.
class GooeyCompactMorph {
  /// Creates a morph profile.
  const GooeyCompactMorph({this.duration = const Duration(milliseconds: 400), this.curve = Curves.easeInOutCubicEmphasized, this.slideOffset = const Offset(0, 0.10), this.scaleFrom = 0.80});
  /// Duration of the morph.
  final Duration duration;
  /// Curve of the morph.
  final Curve curve;
  /// Slide delta in normalized axis units; `dy` scales with the pill height.
  final Offset slideOffset;
  /// Starting scale of both frames.
  final double scaleFrom;
}
```
