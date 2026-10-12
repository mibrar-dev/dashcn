---
title: "Class: InputPasswordToggleFeature"
description: "Toggles between obscured and plain text."
---

```dart
/// Toggles between obscured and plain text.
class InputPasswordToggleFeature extends InputIconFeature {
  /// Creates a password toggle button.
  const InputPasswordToggleFeature({super.position, super.visibility, this.mode = PasswordPeekMode.toggle, this.icon, this.iconShow});
  /// Hold-to-peek or toggle behaviour.
  final PasswordPeekMode mode;
  /// Icon while the text is hidden; defaults to `LucideIcons.eye`.
  final Widget? icon;
  /// Icon while the text is shown; defaults to `LucideIcons.eyeOff`.
  final Widget? iconShow;
  Widget buildIcon(BuildContext context);
  void onPressed(InputFeatureState state, BuildContext context);
  Widget buildButton(InputFeatureState state, BuildContext context);
}
```
