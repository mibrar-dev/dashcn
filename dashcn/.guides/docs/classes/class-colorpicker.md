---
title: "Class: ColorPicker"
description: "A full colour picker: a pad plus hue/alpha bars, a mode dropdown, live  numeric fields, optional colour history and an eye-dropper button."
---

```dart
/// A full colour picker: a pad plus hue/alpha bars, a mode dropdown, live
/// numeric fields, optional colour history and an eye-dropper button.
class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.value, this.onChanged, this.onChanging, this.showAlpha = false, this.initialMode = ColorPickerMode.rgb, this.onModeChanged, this.enableEyeDropper, this.onEyeDropperRequested, this.showHistoryButton = true, this.initialShowHistory = false, this.theme});
  final ColorDerivative value;
  final ValueChanged<ColorDerivative>? onChanged;
  final ValueChanged<ColorDerivative>? onChanging;
  final bool showAlpha;
  final ColorPickerMode initialMode;
  /// Called when the mode dropdown changes.
  final ValueChanged<ColorPickerMode>? onModeChanged;
  /// Eye-dropper button visibility; null uses the theme (true).
  final bool? enableEyeDropper;
  /// Replaces the default eye-dropper action (pick through the nearest
  /// `EyeDropperLayer`, into the colour history when one is in scope).
  final VoidCallback? onEyeDropperRequested;
  /// Whether the history toggle is shown (needs a `RecentColorsScope`).
  final bool showHistoryButton;
  /// Whether the history grid is shown on first build.
  final bool initialShowHistory;
  /// Widget-leg style override (orientation/spacing/slider size live here).
  final ColorPickerTheme? theme;
  State<ColorPicker> createState();
}
```
