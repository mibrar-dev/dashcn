---
title: "Class: EmptyStateAction"
description: "One action of an [EmptyState]."
---

```dart
/// One action of an [EmptyState].
class EmptyStateAction {
  /// Creates an action.
  const EmptyStateAction({required this.label, this.onPressed, this.leading, this.trailing, this.variant, this.size});
  /// Button text.
  final String label;
  /// Called on tap; a null callback renders a disabled button.
  final VoidCallback? onPressed;
  /// Widget shown before the label.
  final Widget? leading;
  /// Widget shown after the label.
  final Widget? trailing;
  /// Button variant; null resolves `primary` for the first action and
  /// `secondary` for the rest.
  final ButtonVariant? variant;
  /// Button size; null resolves the size's own table entry.
  final ButtonSize? size;
}
```
