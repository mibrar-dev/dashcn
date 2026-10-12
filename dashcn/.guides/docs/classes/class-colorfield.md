---
title: "Class: ColorField"
description: "A gradient area that varies an HSV/HSL colour along configurable axes."
---

```dart
/// A gradient area that varies an HSV/HSL colour along configurable axes.
///
/// The field fills the box it is given, so wrap it in a `SizedBox`,
/// `AspectRatio` or an expanded slot:
///
/// ```dart
/// SizedBox(
///   width: 240,
///   height: 160,
///   child: ColorField(
///     color: const Color(0xFF0000FF),
///     saturationAxis: ColorFieldAxis.horizontal,
///     valueAxis: ColorFieldAxis.vertical,
///   ),
/// )
/// ```
class ColorField extends StatelessWidget {
  /// Creates a colour field.
  const ColorField({super.key, required this.color, this.mode = ColorFieldMode.hsv, this.hueAxis = ColorFieldAxis.none, this.saturationAxis = ColorFieldAxis.none, this.valueAxis = ColorFieldAxis.none, this.lightnessAxis = ColorFieldAxis.none, this.alphaAxis = ColorFieldAxis.none, this.theme});
  /// The colour the field is built from.
  final Color color;
  /// Colour space used to paint the field.
  final ColorFieldMode mode;
  /// Hue ramp axis (both modes).
  final ColorFieldAxis hueAxis;
  /// Saturation ramp axis (both modes).
  final ColorFieldAxis saturationAxis;
  /// Value ramp axis ([ColorFieldMode.hsv] only).
  final ColorFieldAxis valueAxis;
  /// Lightness ramp axis ([ColorFieldMode.hsl] only).
  final ColorFieldAxis lightnessAxis;
  /// Alpha ramp axis (both modes).
  final ColorFieldAxis alphaAxis;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final ColorFieldTheme? theme;
  Widget build(BuildContext context);
}
```
