---
title: "Class: ColorInput"
description: "A compact colour field: a colour well and an editable hex text field."
---

```dart
/// A compact colour field: a colour well and an editable hex text field.
///
/// Tapping the well (or Enter/Space while it is focused) opens a full
/// [ColorPicker] — in a popover on desktop widths, in a dialog below 768 px —
/// and the hex field edits the value directly. The widget is controlled:
/// [value] is the source of truth and every edit reports through [onChanged]
/// (live drag previews through [onChanging]). It participates in forms as a
/// `ColorDerivative` field.
///
/// ```dart
/// ColorInput(
///   value: ColorDerivative.fromColor(const Color(0xFF2563EB)),
///   showAlpha: true,
///   onChanged: (value) => setState(() => _color = value),
/// )
/// ```
class ColorInput extends StatefulWidget {
  /// Creates a colour input.
  const ColorInput({super.key, required this.value, this.onChanged, this.onChanging, this.showAlpha, this.initialMode, this.enableEyeDropper, this.showHistory, this.mode, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.enabled, this.theme});
  /// The current colour.
  final ColorDerivative value;
  /// Called with every committed colour.
  final ValueChanged<ColorDerivative>? onChanged;
  /// Called while a picker drag is in flight (live preview).
  final ValueChanged<ColorDerivative>? onChanging;
  /// Whether the picker edits alpha; null resolves true.
  final bool? showAlpha;
  /// Channel mode the picker opens in; null resolves `rgb`.
  final ColorPickerMode? initialMode;
  /// Whether the picker offers screen sampling; null resolves true.
  final bool? enableEyeDropper;
  /// Whether the picker's history toggle is shown; null resolves true.
  final bool? showHistory;
  /// Prompt presentation; null resolves popover at 768 px and wider, dialog
  /// below.
  final PromptMode? mode;
  /// Popover placement relative to the trigger; null resolves top-start.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge in popover mode; null resolves bottom-start.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover surface; null resolves the primitive's 16.
  final EdgeInsetsGeometry? popoverPadding;
  /// Optional heading above the picker in dialog mode.
  final Widget? dialogTitle;
  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final ColorInputTheme? theme;
  State<ColorInput> createState();
}
```
