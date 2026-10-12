---
title: "Class: InputFeatureIconButton"
description: "The shared small icon button used by feature implementations."
---

```dart
/// The shared small icon button used by feature implementations.
class InputFeatureIconButton extends StatelessWidget {
  /// Creates an icon button.
  const InputFeatureIconButton({super.key, required this.icon, this.onPressed, this.onTapDown, this.onTapUp, this.onTapCancel, this.enabled = true});
  final Widget icon;
  final VoidCallback? onPressed;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final bool enabled;
  Widget build(BuildContext context);
}
```
