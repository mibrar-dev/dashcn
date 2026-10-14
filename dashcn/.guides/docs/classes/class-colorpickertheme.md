---
title: "Class: ColorPickerTheme"
description: "Theme data for the `color_picker` component."
---

```dart
/// Theme data for the `color_picker` component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. Like `stepper`/`calendar`,
/// there is no `copyWith`/`lerp`: nothing calls them.
class ColorPickerTheme extends ComponentThemeData implements Mergeable<ColorPickerTheme> {
  const ColorPickerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.spacing, this.controlSpacing, this.orientation, this.enableEyeDropper, this.sliderSize});
  /// Gap between the picker's major sections (pad/history, controls).
  final double? spacing;
  /// Gap between individual controls (sliders, inputs, buttons).
  final double? controlSpacing;
  /// Stack direction; vertical puts the pad above the fields.
  final Axis? orientation;
  /// Whether the eye-dropper button is shown. The default callback samples
  /// the screen through the nearest `EyeDropperLayer`.
  final bool? enableEyeDropper;
  /// Thickness of the hue and alpha sliders.
  final double? sliderSize;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ColorPickerTheme merge(ColorPickerTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
