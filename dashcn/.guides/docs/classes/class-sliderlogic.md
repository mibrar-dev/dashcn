---
title: "Class: SliderLogic"
description: "Builds [SliderView] snapshots and maps pointer positions back to values."
---

```dart
/// Builds [SliderView] snapshots and maps pointer positions back to values.
class SliderLogic {
  /// Normalized `0..1` for [value] over `[min, max]`, clamped.
  static double tForValue(double value, double min, double max);
  /// Value for a normalized [t] over `[min, max]`.
  static double valueForT(double t, double min, double max);
  /// Builds a geometry snapshot.
  ///
  /// [thumbEdgeOffsetPx] pushes thumb centers inward (positive) / outward
  /// (negative) relative to the inside track edge; the default `0.5 *
  /// thumbSize.width`-clamped inset keeps thumbs fully on the track.
  SliderView buildView({required double min, required double max, required SliderSnap snap, required bool enabled, required Rect trackRect, required double trackRadius, required double thumbInset, required bool dragging, required int? activeThumb, required Size thumbSize, required TextDirection textDirection, required double? value, required double? rangeStart, required double? rangeEnd});
  /// Index of the thumb nearest to [dx] (always `0` for single sliders).
  int pickActiveThumb(SliderView view, double dx);
  /// Maps a pointer x position to a clamped, snapped value.
  double valueFromDx(SliderView view, SliderSnap snap, double dx);
}
```
