---
title: "Class: ColorPickerControls"
description: "The controls row of a `ColorPicker`: eye-dropper and history buttons, the  96 px mode `Select` and the live channel fields (the old `ColorControls`)."
---

```dart
/// The controls row of a `ColorPicker`: eye-dropper and history buttons, the
/// 96 px mode `Select` and the live channel fields (the old `ColorControls`).
///
/// A [Wrap] sized to its one-line width ([colorPickerControlsWidth]) keeps the
/// popover look unchanged; narrower widths wrap onto extra runs.
class ColorPickerControls extends StatelessWidget {
  const ColorPickerControls({super.key, required this.value, required this.mode, required this.onChanged, required this.controlSpacing, this.onModeChanged, this.onToggleHistory, this.showHistory = false, this.showHistoryButton = true, this.showAlpha = false, this.enableEyeDropper = true, this.onEyeDropperRequested, this.history});
  /// The colour being edited.
  final ColorDerivative value;
  /// Current mode of the fields.
  final ColorPickerMode mode;
  /// Called when a field, the history grid or the eye dropper commits.
  final ValueChanged<ColorDerivative> onChanged;
  /// Gap between the controls (resolved by the picker).
  final double controlSpacing;
  /// Called with the next mode.
  final ValueChanged<ColorPickerMode>? onModeChanged;
  /// Called when the history toggle is pressed.
  final VoidCallback? onToggleHistory;
  /// Whether the history grid is currently open.
  final bool showHistory;
  /// Whether the history toggle button is shown (needs a history scope).
  final bool showHistoryButton;
  /// Whether the alpha field is shown.
  final bool showAlpha;
  /// Eye-dropper button visibility (already resolved by the picker).
  final bool enableEyeDropper;
  /// Replaces the default eye-dropper action.
  final VoidCallback? onEyeDropperRequested;
  /// Colour history to write an eye-dropper pick into; null skips history.
  final ColorHistoryStorage? history;
  Widget build(BuildContext context);
}
```
