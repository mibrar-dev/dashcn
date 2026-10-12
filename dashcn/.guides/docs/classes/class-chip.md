---
title: "Class: Chip"
description: "A compact button shaped like a upstream chip (`px-2 py-0."
---

```dart
/// A compact button shaped like a upstream chip (`px-2 py-0.5 text-xs`).
///
/// Without [onPressed] the chip is a static token: it paints the variant's
/// colours at full strength and never enters the focus tree. The old widget
/// passed `onPressed ?? () {}`, so a read-only chip was an enabled button that
/// swallowed taps and showed its hover/press rows.
///
/// Pass [onDeleted] for a removable token: Backspace/Delete on the focused
/// chip fires it (the preview wires it to remove the chip from its list).
class Chip extends StatelessWidget {
  /// Creates a chip.
  const Chip({super.key, required this.child, this.onPressed, this.onDeleted, this.leading, this.trailing, this.variant, this.padding, this.onHover, this.onFocusChange, this.focusNode, this.autofocus = false, this.theme});
  /// Chip content, usually a `Text`.
  final Widget child;
  /// Turns the chip into a press target when provided.
  final VoidCallback? onPressed;
  /// Fired when Backspace/Delete hits the focused chip; makes a press-less
  /// chip focusable so removable tokens are keyboard-deletable.
  final VoidCallback? onDeleted;
  /// Widget shown before [child].
  final Widget? leading;
  /// Widget shown after [child].
  final Widget? trailing;
  /// Button variant override; null resolves `ChipTheme.variant`.
  final ButtonVariant? variant;
  /// Padding override; null resolves `ChipTheme.padding`.
  final EdgeInsetsGeometry? padding;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Focus node of a pressable chip; ignored when [onPressed] is null.
  final FocusNode? focusNode;
  /// Whether a pressable chip requests focus when first built.
  final bool autofocus;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final ChipTheme? theme;
  Widget build(BuildContext context);
}
```
