---
title: "Class: HSVSliderTheme"
description: "Per-component theme data for the `hsv` slider."
---

```dart
/// Per-component theme data for the `hsv` slider.
class HSVSliderTheme extends ComponentThemeData implements Mergeable<HSVSliderTheme> {
  /// Creates the theme data.
  const HSVSliderTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.slider});
  /// Widget-wide slider slice.
  final HSVSliderStyle? slider;
  HSVSliderTheme merge(HSVSliderTheme? fallback);
  /// Colours step at `t = 0.5`; geometry is lerped.
  static HSVSliderTheme lerp(HSVSliderTheme a, HSVSliderTheme b, double t);
}
```
