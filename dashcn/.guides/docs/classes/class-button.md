---
title: "Class: Button"
description: "A pressable action control."
---

```dart
/// A pressable action control.
///
/// Use a [ButtonGroup] to connect several buttons; on/off state belongs to the
/// separate `Toggle` component. Rare gestures (secondary click, tap-down
/// tracking) are available through an outer `GestureDetector`.
class Button extends StatefulWidget {
  /// Creates a button.
  const Button({super.key, required this.child, this.variant = ButtonVariant.primary, this.size = ButtonSize.md, this.onPressed, this.onLongPress, this.onHover, this.onFocusChange, this.leading, this.trailing, this.focusNode, this.autofocus = false, this.enabled, this.theme});
  /// Button content, usually a `Text` or an `Icon`.
  final Widget child;
  /// Visual variant. Defaults to [ButtonVariant.primary].
  final ButtonVariant variant;
  /// Fixed size row. Defaults to [ButtonSize.md].
  final ButtonSize size;
  /// Called on tap. When null the button is disabled unless [enabled] is true.
  final VoidCallback? onPressed;
  /// Called on long press. Ignored while the button is disabled.
  final VoidCallback? onLongPress;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Widget shown before [child].
  final Widget? leading;
  /// Widget shown after [child].
  final Widget? trailing;
  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null; otherwise the internal `Clickable` owns its own node.
  final FocusNode? focusNode;
  /// Whether the button requests focus when first built.
  final bool autofocus;
  /// Overrides the enabled state; null means `onPressed != null`.
  final bool? enabled;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final ButtonVariantStyle? theme;
  State<Button> createState();
}
```
