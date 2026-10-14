---
title: "Class: InputAboveBelowFeature"
description: "Adds a widget above or below the decorated field."
---

```dart
/// Adds a widget above or below the decorated field.
class InputAboveBelowFeature extends InputFeature {
  /// Creates an above/below feature; defaults to below.
  const InputAboveBelowFeature({super.visibility, this.child, this.position = InputFeaturePosition.below});
  /// Creates an above feature.
  const InputAboveBelowFeature.above(this.child, {super.visibility});
  /// Creates a below feature.
  const InputAboveBelowFeature.below(this.child, {super.visibility});
  /// The widget shown above/below the field.
  final Widget? child;
  /// Where [child] is placed.
  final InputFeaturePosition position;
  Widget wrap(InputFeatureState state, Widget child);
}
```
