---
title: "Class: SliderStyle"
description: "One variant's styling slice."
---

```dart
/// One variant's styling slice. Every field is nullable: an override leg sets
/// only what it changes and [merge] keeps the lower leg's remaining fields.
class SliderStyle implements Mergeable<SliderStyle> {
  /// Creates a slider style slice.
  const SliderStyle({this.track, this.fill, this.thumb, this.thumbBorder, this.mark, this.trackHeight, this.trackRadius, this.thumbSize, this.thumbShape});
  /// Track (remaining) color.
  final StateValue<ThemedColor>? track;
  /// Fill (active range) color.
  final StateValue<ThemedColor>? fill;
  /// Thumb fill color.
  final StateValue<ThemedColor>? thumb;
  /// Thumb border color (circle thumb).
  final StateValue<ThemedColor>? thumbBorder;
  /// Mark (dot/bar) color for unfilled marks.
  final StateValue<ThemedColor>? mark;
  /// Track height in logical pixels.
  final double? trackHeight;
  /// Track corner radius; clamped to half the track height at paint time.
  final double? trackRadius;
  /// Thumb layout size.
  final Size? thumbSize;
  /// Thumb shape for this variant.
  final SliderThumbShape? thumbShape;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SliderStyle merge(SliderStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static SliderStyle lerp(SliderStyle a, SliderStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
