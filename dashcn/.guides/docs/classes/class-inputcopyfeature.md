---
title: "Class: InputCopyFeature"
description: "Selects all text and copies it to the clipboard."
---

```dart
/// Selects all text and copies it to the clipboard.
class InputCopyFeature extends InputIconFeature {
  /// Creates a copy button; trailing, shown while text is not empty.
  const InputCopyFeature({super.position, super.visibility = InputFeatureVisibility.textNotEmpty, this.icon});
  /// Custom icon; defaults to `LucideIcons.copy`.
  final Widget? icon;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
}
```
