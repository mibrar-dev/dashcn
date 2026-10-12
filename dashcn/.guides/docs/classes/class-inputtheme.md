---
title: "Class: InputTheme"
description: "One input's visual contract."
---

```dart
/// One input's visual contract.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. There are no variants and
/// no size enum; [height] is the field's minimum height.
class InputTheme extends ComponentThemeData implements Mergeable<InputTheme> {
  /// Creates an input theme.
  const InputTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.textStyle, this.hintStyle, this.cursorColor, this.height});
  /// Per-state fill of the input surface.
  final StateValue<ThemedColor>? background;
  /// Per-state border color; null draws no border. The focus ring is a
  /// separate `FocusOutline`, not a border row.
  final StateValue<ThemedColor>? borderColor;
  /// Border width used when [borderColor] resolves non-null.
  final double? borderWidth;
  /// Corner radius; null resolves `theme.borderRadiusMd` at build.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding; null resolves the 12x8 default.
  final EdgeInsetsGeometry? padding;
  /// Text style override; its color wins over the foreground token.
  final TextStyle? textStyle;
  /// Hint/placeholder style override.
  final TextStyle? hintStyle;
  /// Cursor color; null resolves the `primary` token.
  final ThemedColor? cursorColor;
  /// Minimum field height; null resolves 36.
  final double? height;
  /// Returns a copy with the given fields replaced.
  InputTheme copyWith({ValueGetter<StateValue<ThemedColor>?>? background, ValueGetter<StateValue<ThemedColor>?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TextStyle?>? textStyle, ValueGetter<TextStyle?>? hintStyle, ValueGetter<ThemedColor?>? cursorColor, ValueGetter<double?>? height});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  InputTheme merge(InputTheme? fallback);
  /// State scales and colors step at t < 0.5; scalars are lerped.
  static InputTheme lerp(InputTheme a, InputTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
