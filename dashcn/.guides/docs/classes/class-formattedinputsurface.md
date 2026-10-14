---
title: "Class: FormattedInputSurface"
description: "Resolved visual values for one formatted input build."
---

```dart
/// Resolved visual values for one formatted input build.
class FormattedInputSurface {
  /// Creates a resolved surface.
  const FormattedInputSurface({required this.decoration, required this.borderRadius, required this.padding, required this.height, required this.textStyle, required this.placeholderStyle, required this.separatorStyle, required this.leadingGap, required this.partGap, required this.cursorColor});
  /// Field surface decoration (fill + border), excluding the focus ring.
  final BoxDecoration decoration;
  /// Corner radius of the focus ring.
  final BorderRadiusGeometry borderRadius;
  /// Density-resolved inner padding.
  final EdgeInsetsGeometry padding;
  /// Minimum field height.
  final double height;
  /// Resolved segment text style.
  final TextStyle textStyle;
  /// Resolved placeholder style.
  final TextStyle placeholderStyle;
  /// Resolved separator style.
  final TextStyle separatorStyle;
  /// Space between `leading` and the first part.
  final double leadingGap;
  /// Space between two parts.
  final double partGap;
  /// Resolved cursor colour.
  final Color cursorColor;
}
```
