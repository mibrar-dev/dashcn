---
title: "Class: ButtonVariantStyle"
description: "One variant's state-aware styling slice."
---

```dart
/// One variant's state-aware styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class ButtonVariantStyle implements Mergeable<ButtonVariantStyle> {
  /// Creates a variant style slice.
  const ButtonVariantStyle({this.background, this.foreground, this.borderColor, this.borderWidth, this.decoration, this.padding, this.textStyle});
  /// Per-state fill of the button surface.
  final StateValue<ThemedColor>? background;
  /// Per-state label/icon color.
  final StateValue<ThemedColor>? foreground;
  /// Per-state border color; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Per-state [TextDecoration] (link underline); null draws none.
  final StateValue<TextDecoration>? decoration;
  /// Padding override; null falls back to the size table.
  final EdgeInsetsGeometry? padding;
  /// Text style override; its color is ignored (taken from [foreground]).
  final TextStyle? textStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ButtonVariantStyle merge(ButtonVariantStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static ButtonVariantStyle lerp(ButtonVariantStyle a, ButtonVariantStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
