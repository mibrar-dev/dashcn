---
title: "Class: ChipTheme"
description: "Theme container for the chip component."
---

```dart
/// Theme container for the chip component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ChipTheme extends ComponentThemeData implements Mergeable<ChipTheme> {
  /// Creates a chip theme.
  const ChipTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.variant, this.padding, this.textStyle, this.style, this.buttonPadding, this.buttonIconSize});
  /// Button variant the chips render with. Default:
  /// [ButtonVariant.secondary].
  final ButtonVariant? variant;
  /// Padding between the chip border and its content. Default:
  /// [chipDefaultPadding].
  final EdgeInsetsGeometry? padding;
  /// Label text style; its colour is ignored (the button style owns it).
  final TextStyle? textStyle;
  /// Extra per-state rows merged over the variant's button style.
  final ButtonVariantStyle? style;
  /// Padding of an inner [ChipButton]. Default:
  /// [chipButtonDefaultPadding].
  final EdgeInsetsGeometry? buttonPadding;
  /// Icon size of an inner [ChipButton]. Default:
  /// [chipButtonDefaultIconSize].
  final double? buttonIconSize;
  /// Returns a copy with the given fields replaced.
  ChipTheme copyWith({ValueGetter<ButtonVariant?>? variant, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<TextStyle?>? textStyle, ValueGetter<ButtonVariantStyle?>? style, ValueGetter<EdgeInsetsGeometry?>? buttonPadding, ValueGetter<double?>? buttonIconSize});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ChipTheme merge(ChipTheme? fallback);
  /// Enums step at `t = 0.5`; padding, icon size and text styles interpolate.
  static ChipTheme lerp(ChipTheme a, ChipTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
