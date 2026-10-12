---
title: "Extension: ColorExtension"
description: "Color manipulation utilities."
---

```dart
/// Color manipulation utilities.
extension ColorExtension on Color {
  /// Multiplies the alpha channel by [factor].
  Color scaleAlpha(double factor);
  /// Returns a color whose HSL lightness moves [luminanceContrast] toward the
  /// opposite end of the scale.
  Color getContrastColor([double luminanceContrast = 1]);
  /// Sets the HSL lightness of this color.
  Color withLuminance(double luminance);
  /// ARGB hex string (`AARRGGBB`), optionally without alpha / hash sign.
  String toHex({bool includeHashSign = false, bool includeAlpha = true});
  /// Converts this color to [HSLColor].
  HSLColor toHSL();
  /// Converts this color to [HSVColor].
  HSVColor toHSV();
}
```
