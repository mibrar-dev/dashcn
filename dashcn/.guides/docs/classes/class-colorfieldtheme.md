---
title: "Class: ColorFieldTheme"
description: "Surface styling for a [ColorField]-style gradient area."
---

```dart
/// Surface styling for a [ColorField]-style gradient area.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ColorFieldTheme extends ComponentThemeData implements Mergeable<ColorFieldTheme> {
  /// Creates a colour-field theme.
  const ColorFieldTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.borderColor, this.borderWidth, this.borderRadius, this.checkerboard});
  /// Border colour. Default: the `border` token.
  final ThemedColor? borderColor;
  /// Border width. Default: 1. `0` hides the border.
  final double? borderWidth;
  /// Corner radius; null resolves the ambient `radiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Whether a checkerboard is painted behind translucent colours (alpha ramp
  /// or a colour with alpha < 1). Default: true.
  final bool? checkerboard;
  /// Returns a copy with the given fields replaced.
  ColorFieldTheme copyWith({ValueGetter<ThemedColor?>? borderColor, ValueGetter<double?>? borderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? checkerboard});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ColorFieldTheme merge(ColorFieldTheme? fallback);
  /// Colours and flags step at `t = 0.5`; dimensions are lerped.
  static ColorFieldTheme lerp(ColorFieldTheme a, ColorFieldTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
