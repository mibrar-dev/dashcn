---
title: "Class: GooeyCloseButton"
description: "Close button for an expanded gooey toast."
---

```dart
/// Close button for an expanded gooey toast.
class GooeyCloseButton extends StatelessWidget {
  /// Creates a close button.
  const GooeyCloseButton({super.key, required this.onDismiss, this.onFocusChange});
  /// Called to dismiss the toast.
  final VoidCallback onDismiss;
  /// Called when keyboard focus enters or leaves the button.
  final ValueChanged<bool>? onFocusChange;
  Widget build(BuildContext context);
}
```
