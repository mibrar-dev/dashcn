---
title: "Class: InputPasteFeature"
description: "Appends clipboard text at the end of the field."
---

```dart
/// Appends clipboard text at the end of the field.
class InputPasteFeature extends InputIconFeature {
  /// Creates a paste button.
  const InputPasteFeature({super.position, super.visibility, this.icon});
  /// Custom icon; defaults to `LucideIcons.clipboard`.
  final Widget? icon;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
}
```
