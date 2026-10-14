---
title: "Class: SwitchStyle"
description: "One switch value's styling slice."
---

```dart
/// One switch value's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class SwitchStyle implements Mergeable<SwitchStyle> {
  /// Creates a switch style slice.
  const SwitchStyle({this.trackColor, this.thumbColor, this.borderColor, this.borderWidth, this.trackSize, this.thumbSize, this.travel, this.gap, this.labelStyle});
  /// Per-state fill of the track.
  final StateValue<ThemedColor>? trackColor;
  /// Per-state fill of the thumb.
  final StateValue<ThemedColor>? thumbColor;
  /// Per-state border colour of the track; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Track size; null resolves [switchDefaultTrackSize].
  final Size? trackSize;
  /// Thumb side length; null resolves [switchDefaultThumbSize].
  final double? thumbSize;
  /// Thumb travel between the off and on positions; null derives it from the
  /// track and thumb sizes at build (track width - thumb - 2, the upstream
  /// `translate-x-[calc(100%-2px)]` slack, minus any border).
  final double? travel;
  /// Space between the switch and [Switch.label]; null resolves 8.
  final double? gap;
  /// Label text style; its colour falls back to the `foreground` token.
  final TextStyle? labelStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SwitchStyle merge(SwitchStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static SwitchStyle lerp(SwitchStyle a, SwitchStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
