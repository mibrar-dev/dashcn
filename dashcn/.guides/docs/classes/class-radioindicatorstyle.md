---
title: "Class: RadioIndicatorStyle"
description: "The circle: its outline, fill and dot."
---

```dart
/// The circle: its outline, fill and dot.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class RadioIndicatorStyle implements Mergeable<RadioIndicatorStyle> {
  /// Creates an indicator style slice.
  const RadioIndicatorStyle({this.borderColor, this.borderWidth, this.background, this.dotColor, this.dotSize, this.size, this.duration});
  /// Per-state outline colour of the circle.
  final StateValue<ThemedColor>? borderColor;
  /// Outline width; null draws no border.
  final double? borderWidth;
  /// Per-state fill of the circle.
  final StateValue<ThemedColor>? background;
  /// Colour of the inner dot drawn while selected.
  final ThemedColor? dotColor;
  /// Diameter of the inner dot; null resolves half the [size].
  final double? dotSize;
  /// Circle side; null resolves [radioDefaultIndicatorSize].
  final double? size;
  /// Animation duration; null resolves [radioDefaultDuration].
  final Duration? duration;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  RadioIndicatorStyle merge(RadioIndicatorStyle? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
