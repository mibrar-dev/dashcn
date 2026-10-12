---
title: "Class: ChipButton"
description: "The borderless control embedded in a [Chip] (remove, expand, clear)."
---

```dart
/// The borderless control embedded in a [Chip] (remove, expand, clear).
///
/// It renders the `ghost` button row with no padding, so it lines up with the
/// chip's content and shows no fill until it is hovered.
class ChipButton extends StatelessWidget {
  /// Creates an inner chip control.
  const ChipButton({super.key, required this.child, this.onPressed, this.iconSize, this.focusNode, this.autofocus = false, this.theme});
  /// Control content, usually an `Icon`.
  final Widget child;
  /// Called on tap; null makes the control static.
  final VoidCallback? onPressed;
  /// Icon size override; null resolves `ChipTheme.buttonIconSize`.
  final double? iconSize;
  /// Focus node; ignored when [onPressed] is null.
  final FocusNode? focusNode;
  /// Whether the control requests focus when first built.
  final bool autofocus;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final ChipTheme? theme;
  Widget build(BuildContext context);
}
```
