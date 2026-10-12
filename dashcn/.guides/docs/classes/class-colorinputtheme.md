---
title: "Class: ColorInputTheme"
description: "Behaviour and trigger styling for the `color_input` component."
---

```dart
/// Behaviour and trigger styling for the `color_input` component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ColorInputTheme extends ComponentThemeData implements Mergeable<ColorInputTheme> {
  /// Creates a colour-input theme.
  const ColorInputTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.mode, this.pickerMode, this.showAlpha, this.enableEyeDropper, this.showHistory, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.gap, this.swatchSize, this.swatchBorderRadius, this.swatchBorderColor});
  /// Prompt presentation; null resolves popover at 768 px and wider, dialog
  /// below.
  final PromptMode? mode;
  /// Channel mode the picker opens in; null resolves `rgb`.
  final ColorPickerMode? pickerMode;
  /// Whether the picker edits alpha; null resolves true.
  final bool? showAlpha;
  /// Whether the picker offers screen sampling; null resolves true.
  final bool? enableEyeDropper;
  /// Whether the picker's history toggle is shown; null resolves true.
  final bool? showHistory;
  /// Popover placement relative to the trigger; null resolves top-start.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge in popover mode; null resolves bottom-start.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover surface; null resolves the primitive's 16.
  final EdgeInsetsGeometry? popoverPadding;
  /// Gap between the colour well and the hex field; null resolves 8.
  final double? gap;
  /// Edge length of the colour well; null resolves 36 (upstream h-9).
  final double? swatchSize;
  /// Corner radius of the well; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? swatchBorderRadius;
  /// Well border colour; null resolves the `border` token.
  final ThemedColor? swatchBorderColor;
  /// Returns a copy with the given fields replaced.
  ColorInputTheme copyWith({ValueGetter<PromptMode?>? mode, ValueGetter<ColorPickerMode?>? pickerMode, ValueGetter<bool?>? showAlpha, ValueGetter<bool?>? enableEyeDropper, ValueGetter<bool?>? showHistory, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<EdgeInsetsGeometry?>? popoverPadding, ValueGetter<double?>? gap, ValueGetter<double?>? swatchSize, ValueGetter<BorderRadiusGeometry?>? swatchBorderRadius, ValueGetter<ThemedColor?>? swatchBorderColor});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ColorInputTheme merge(ColorInputTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
