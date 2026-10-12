---
title: "Class: InputClearFeature"
description: "Clears the field text."
---

```dart
/// Clears the field text.
class InputClearFeature extends InputIconFeature {
  /// Creates a clear button; trailing, shown while text is not empty.
  const InputClearFeature({super.position, super.visibility = InputFeatureVisibility.textNotEmpty, this.icon});
  /// Custom icon; defaults to `LucideIcons.x`.
  final Widget? icon;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
}
```
