---
title: "Class: FormattedInputTheme"
description: "Visual contract of a formatted (masked) field."
---

```dart
/// Visual contract of a formatted (masked) field.
class FormattedInputTheme extends ComponentThemeData implements Mergeable<FormattedInputTheme> {
  /// Creates a formatted input theme.
  const FormattedInputTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.background, this.hoveredBackground, this.borderColor, this.borderWidth, this.borderRadius, this.padding, this.height, this.textStyle, this.placeholderStyle, this.separatorStyle, this.leadingGap, this.partGap});
  /// Field fill at rest. Default: `input` at 30%.
  final ThemedColor? background;
  /// Field fill while hovered. Default: `input` at 50%.
  final ThemedColor? hoveredBackground;
  /// Field border. Default: the `input` token.
  final ThemedColor? borderColor;
  /// Border width. Default: 1.
  final double? borderWidth;
  /// Corner radius; null resolves `theme.borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Inner padding. Default: 8 horizontal, 4 vertical (scaled).
  final EdgeInsetsGeometry? padding;
  /// Minimum field height. Default: 36 (the upstream input height).
  final double? height;
  /// Segment text style; null takes the theme mono at `text-sm`.
  final TextStyle? textStyle;
  /// Placeholder style; null takes `text-sm` muted.
  final TextStyle? placeholderStyle;
  /// Style of the static separators; null takes [textStyle].
  final TextStyle? separatorStyle;
  /// Space between `leading` and the first part. Default: 8 (scaled).
  final double? leadingGap;
  /// Space between two parts. Default: 0 (segments are adjacent).
  final double? partGap;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FormattedInputTheme merge(FormattedInputTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
