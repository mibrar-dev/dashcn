---
title: "Class: CheckboxStyle"
description: "One checkbox value's styling slice."
---

```dart
/// One checkbox value's styling slice.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining states/fields.
class CheckboxStyle implements Mergeable<CheckboxStyle> {
  /// Creates a checkbox style slice.
  const CheckboxStyle({this.background, this.borderColor, this.indicatorColor, this.size, this.indicatorSize, this.borderWidth, this.borderRadius, this.gap, this.padding, this.labelStyle});
  /// Per-state fill of the box.
  final StateValue<ThemedColor>? background;
  /// Per-state border colour of the box; null draws no border.
  final StateValue<ThemedColor>? borderColor;
  /// Colour of the check mark / dash. Null hides the indicator.
  final ThemedColor? indicatorColor;
  /// Side length of the box; null resolves 16 at build.
  final double? size;
  /// Side length of the indicator glyph; null resolves `size * 0.75`.
  final double? indicatorSize;
  /// Border width; null resolves 1 at build.
  final double? borderWidth;
  /// Corner radius of the box; null resolves the ambient `radiusSm`.
  final BorderRadiusGeometry? borderRadius;
  /// Space between the box and [Checkbox.label]; null resolves 8.
  final double? gap;
  /// Padding between the control edge and its content; null resolves 2.
  final EdgeInsetsGeometry? padding;
  /// Label text style; its colour is taken from the ambient foreground unless
  /// the style carries one.
  final TextStyle? labelStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CheckboxStyle merge(CheckboxStyle? fallback);
  /// State scales are stepped at t < 0.5; dimensions are lerped.
  static CheckboxStyle lerp(CheckboxStyle a, CheckboxStyle b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
