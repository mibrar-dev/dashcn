---
title: "Class: InputStepperButtonFeature"
description: "Adds one increment/decrement button for numeric input."
---

```dart
/// Adds one increment/decrement button for numeric input.
class InputStepperButtonFeature extends InputIconFeature {
  /// Creates a stepper button.
  const InputStepperButtonFeature({super.position, super.visibility, this.step = 1.0, this.invalidValue = 0.0, this.min, this.max, this.icon = const Icon(LucideIcons.plus)});
  /// Creates a decrement button.
  const InputStepperButtonFeature.decrement({super.position, super.visibility, this.step = -1.0, this.invalidValue = 0.0, this.min, this.max, this.icon = const Icon(LucideIcons.minus)});
  /// Amount added on each press (negative subtracts).
  final double step;
  /// Fallback value when the text does not parse; null keeps the text.
  final double? invalidValue;
  /// Minimum allowed value.
  final double? min;
  /// Maximum allowed value.
  final double? max;
  /// The button icon.
  final Widget icon;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
}
```
