---
title: "Class: InputRevalidateFeature"
description: "Re-runs the input's validator immediately."
---

```dart
/// Re-runs the input's validator immediately.
class InputRevalidateFeature extends InputIconFeature {
  /// Creates a revalidate button.
  const InputRevalidateFeature({super.position, super.visibility, this.icon});
  /// Custom icon; defaults to `LucideIcons.refreshCw`.
  final Widget? icon;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
}
```
