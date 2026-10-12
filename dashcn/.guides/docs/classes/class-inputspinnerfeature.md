---
title: "Class: InputSpinnerFeature"
description: "Adds up/down buttons (and an optional drag gesture) for numeric input."
---

```dart
/// Adds up/down buttons (and an optional drag gesture) for numeric input.
class InputSpinnerFeature extends InputFeature {
  /// Creates a spinner feature.
  const InputSpinnerFeature({super.visibility, super.skipFocusTraversal, this.step = 1.0, this.enableGesture = true, this.invalidValue = 0.0, this.min, this.max});
  /// Amount added/subtracted on each step.
  final double step;
  /// Whether vertical drags also change the value.
  final bool enableGesture;
  /// Fallback value when the text does not parse; null keeps the text.
  final double? invalidValue;
  /// Minimum allowed value.
  final double? min;
  /// Maximum allowed value.
  final double? max;
  Iterable<Widget> buildTrailing(InputFeatureState state, BuildContext context);
}
```
