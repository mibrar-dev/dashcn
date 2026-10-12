---
title: "Class: ColorDerivative"
description: "An abstract base class representing a color that can be transformed between  different color spaces."
---

```dart
/// An abstract base class representing a color that can be transformed between
/// different color spaces.
///
/// ```dart
/// final derivative = ColorDerivative.fromColor(const Color(0xFF0080FF));
/// final muted = derivative.changeToHSVSaturation(0.5);
/// return muted.toColor();
/// ```
abstract class ColorDerivative {
  /// Creates a [ColorDerivative] from a Flutter [Color] using HSV internally.
  static ColorDerivative fromColor(Color color);
  /// Creates a [ColorDerivative] from an [HSVColor].
  factory ColorDerivative.fromHSV(HSVColor color);
  /// Creates a [ColorDerivative] from an [HSLColor].
  factory ColorDerivative.fromHSL(HSLColor color);
  /// Parses a hex string (`#RGB`, `#RRGGBB`, `#AARRGGBB`) into a
  /// [ColorDerivative], or null when [text] is not a valid hex colour.
  static ColorDerivative? fromHex(String text);
  /// Creates a const [ColorDerivative].
  const ColorDerivative();
  /// Converts this color derivative to a Flutter [Color].
  Color toColor();
  /// Converts this color derivative to an [HSVColor].
  HSVColor toHSVColor();
  /// Converts this color derivative to an [HSLColor].
  HSLColor toHSLColor();
  /// The opacity (alpha) value, 0.0–1.0.
  double get opacity;
  /// Hue in HSL space, 0.0–360.0.
  double get hslHue;
  /// Saturation in HSL space, 0.0–1.0.
  double get hslSat;
  /// Lightness in HSL space, 0.0–1.0.
  double get hslVal;
  /// Hue in HSV space, 0.0–360.0.
  double get hsvHue;
  /// Saturation in HSV space, 0.0–1.0.
  double get hsvSat;
  /// Value (brightness) in HSV space, 0.0–1.0.
  double get hsvVal;
  /// Red channel, 0–255.
  int get red;
  /// Green channel, 0–255.
  int get green;
  /// Blue channel, 0–255.
  int get blue;
  /// Re-expresses this colour using [other]'s internal colour space.
  ColorDerivative transform(ColorDerivative old);
  /// Returns a copy with the opacity replaced by [alpha].
  ColorDerivative changeToOpacity(double alpha);
  /// Returns a copy of [color] expressed in this colour's space.
  ColorDerivative changeToColor(Color color);
  /// Returns a copy of [color] expressed in this colour's space.
  ColorDerivative changeToHSV(HSVColor color);
  /// Returns a copy of [color] expressed in this colour's space.
  ColorDerivative changeToHSL(HSLColor color);
  /// Replaces the red channel (0–255).
  ColorDerivative changeToColorRed(double red);
  /// Replaces the green channel (0–255).
  ColorDerivative changeToColorGreen(double green);
  /// Replaces the blue channel (0–255).
  ColorDerivative changeToColorBlue(double blue);
  /// Replaces the HSV hue (0–360).
  ColorDerivative changeToHSVHue(double hue);
  /// Replaces the HSV saturation (0–1).
  ColorDerivative changeToHSVSaturation(double saturation);
  /// Replaces the HSV value (0–1).
  ColorDerivative changeToHSVValue(double value);
  /// Replaces the alpha channel (0–1) in HSV space.
  ColorDerivative changeToHSVAlpha(double alpha);
  /// Replaces the HSL hue (0–360).
  ColorDerivative changeToHSLHue(double hue);
  /// Replaces the HSL saturation (0–1).
  ColorDerivative changeToHSLSaturation(double saturation);
  /// Replaces the HSL lightness (0–1).
  ColorDerivative changeToHSLLightness(double lightness);
}
```
