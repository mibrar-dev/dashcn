---
title: "Class: ToggleStyle"
description: "One toggle state's styling slice."
---

```dart
/// One toggle state's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class ToggleStyle implements Mergeable<ToggleStyle> {
  /// Creates a toggle style slice.
  const ToggleStyle({this.background, this.foreground, this.borderColor, this.borderWidth, this.decoration, this.padding, this.textStyle});
  /// Per-state fill of the toggle surface.
  final StateValue<ThemedColor>? background;
  /// Per-state label/icon color.
  final StateValue<ThemedColor>? foreground;
  /// Per-state border color; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Per-state [TextDecoration].
  final StateValue<TextDecoration>? decoration;
  /// Padding override; null falls back to the toggle default padding
  /// (upstream `px-2`, density-scaled).
  final EdgeInsetsGeometry? padding;
  /// Text style override; its color is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ToggleStyle merge(ToggleStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static ToggleStyle lerp(ToggleStyle a, ToggleStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
