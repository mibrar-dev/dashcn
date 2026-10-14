---
title: "Class: TabButton"
description: "A tight pressable for tab rows."
---

```dart
/// A tight pressable for tab rows. Unlike `Button` it carries no minimum size
/// or padding, so strips keep their own metrics.
class TabButton extends StatelessWidget {
  /// Creates a tab button.
  const TabButton({super.key, required this.child, this.onPressed, this.enabled, this.selected = false, this.focusNode, this.onHover, this.onFocusChange, this.padding, this.shortcuts, this.actions});
  /// Button content, usually a label.
  final Widget child;
  /// Called on tap; null disables unless [enabled] is true.
  final VoidCallback? onPressed;
  /// Enabled override; null means `onPressed != null`.
  final bool? enabled;
  /// Selected state for assistive tech.
  final bool selected;
  /// Focus node; owned internally when null.
  final FocusNode? focusNode;
  /// Called on hover/focus changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Padding around [child]; null means none.
  final EdgeInsetsGeometry? padding;
  /// Extra keyboard shortcuts (arrow-key maps go here).
  final Map<LogicalKeySet, Intent>? shortcuts;
  /// Actions for [shortcuts].
  final Map<Type, Action<Intent>>? actions;
  Widget build(BuildContext context);
}
```
