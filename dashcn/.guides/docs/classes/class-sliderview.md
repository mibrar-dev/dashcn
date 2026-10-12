---
title: "Class: SliderView"
description: "Immutable snapshot of the geometry derived from config + value."
---

```dart
/// Immutable snapshot of the geometry derived from config + value.
class SliderView {
  /// Creates a geometry snapshot.
  const SliderView({required this.min, required this.max, required this.enabled, required this.isRange, required this.textDirection, required this.trackRect, required this.trackRadius, required this.thumbInset, required this.thumbs, required this.marks, this.activeThumb, this.value, this.rangeStart, this.rangeEnd, this.activeRect, this.fillRect});
  /// Domain minimum.
  final double min;
  /// Domain maximum.
  final double max;
  /// Interaction enabled.
  final bool enabled;
  /// Whether this is a two-thumb slider.
  final bool isRange;
  /// Resolved text direction.
  final TextDirection textDirection;
  /// Track bounds in canvas coordinates.
  final Rect trackRect;
  /// Track corner radius (already clamped).
  final double trackRadius;
  /// Effective horizontal inset of thumb centers.
  final double thumbInset;
  /// Thumb placements.
  final List<SliderThumb> thumbs;
  /// Snap marks to paint.
  final List<SliderMark> marks;
  /// Index of the active thumb, if any.
  final int? activeThumb;
  /// Single-mode value (null in range mode).
  final double? value;
  /// Range start (range mode only).
  final double? rangeStart;
  /// Range end (range mode only).
  final double? rangeEnd;
  /// Fill rect between range thumbs (range mode only).
  final Rect? activeRect;
  /// Fill rect from start to the single thumb (single mode only).
  final Rect? fillRect;
}
```
