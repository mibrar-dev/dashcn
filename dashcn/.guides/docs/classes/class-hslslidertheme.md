---
title: "Class: HSLSliderTheme"
description: "Per-component theme data for the `hsl` slider."
---

```dart
/// Per-component theme data for the `hsl` slider.
class HSLSliderTheme extends ComponentThemeData implements Mergeable<HSLSliderTheme> {
  /// Creates the theme data.
  const HSLSliderTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.slider});
  /// Widget-wide slider slice.
  final HSLSliderStyle? slider;
  HSLSliderTheme merge(HSLSliderTheme? fallback);
  /// Colours step at `t = 0.5`; geometry is lerped.
  static HSLSliderTheme lerp(HSLSliderTheme a, HSLSliderTheme b, double t);
}
```
