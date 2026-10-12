---
title: "Class: InputSurface"
description: "Resolved visual values for one input build."
---

```dart
/// Resolved visual values for one input build.
class InputSurface {
  /// Creates a resolved surface.
  const InputSurface({required this.decoration, required this.borderRadius, required this.padding, required this.textStyle, required this.hintStyle, required this.cursorColor, required this.backgroundCursorColor, required this.selectionColor, required this.errorStyle, required this.minHeight, required this.gap});
  /// Field surface decoration.
  final BoxDecoration decoration;
  /// Corner radius of the focus ring.
  final BorderRadiusGeometry borderRadius;
  /// Density-resolved inner padding.
  final EdgeInsetsGeometry padding;
  /// Resolved text style.
  final TextStyle textStyle;
  /// Resolved placeholder style.
  final TextStyle hintStyle;
  /// Resolved cursor color.
  final Color cursorColor;
  /// Cursor color painted when the field is not focused.
  final Color backgroundCursorColor;
  /// Selection highlight color.
  final Color selectionColor;
  /// Error message style.
  final TextStyle errorStyle;
  /// Minimum field height.
  final double minHeight;
  /// Spacing between adornments and error text.
  final double gap;
}
```
