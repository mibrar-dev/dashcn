---
title: "Class: Badge"
description: "A small rounded label used for status, counts and categories."
---

```dart
/// A small rounded label used for status, counts and categories.
///
/// Non-interactive by default: without [onPressed] the badge paints a plain
/// surface and never enters the focus tree. The old badges were always
/// `enabled: true` buttons wrapped in `ExcludeFocus`, so even a static badge
/// showed hover/press styling and swallowed a pointer click with no handler.
class Badge extends StatelessWidget {
  /// Creates a badge.
  const Badge({super.key, required this.child, this.variant = BadgeVariant.primary, this.leading, this.trailing, this.onPressed, this.onHover, this.onFocusChange, this.focusNode, this.autofocus = false, this.showAsDot = false, this.theme});
  /// Badge content. Ignored when [showAsDot] is true.
  final Widget child;
  /// Visual variant. Defaults to [BadgeVariant.primary].
  final BadgeVariant variant;
  /// Widget shown before [child].
  final Widget? leading;
  /// Widget shown after [child].
  final Widget? trailing;
  /// Turns the badge into a press target when provided.
  final VoidCallback? onPressed;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Focus node of a pressable badge; ignored when [onPressed] is null.
  final FocusNode? focusNode;
  /// Whether a pressable badge requests focus when first built.
  final bool autofocus;
  /// Draws a fixed-size dot instead of [child] (upstream `showAsDot`).
  final bool showAsDot;
  /// Widget-leg style override, merged over the component/app/defaults.
  final BadgeStyle? theme;
  /// Whether this badge reacts to input.
  bool get isInteractive;
  Widget build(BuildContext context);
}
```
