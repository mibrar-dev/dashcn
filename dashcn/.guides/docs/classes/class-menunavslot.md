---
title: "Class: MenuNavSlot"
description: "One focusable row as a [RovingGroup] sees it."
---

```dart
/// One focusable row as a [RovingGroup] sees it.
class MenuNavSlot {
  /// Creates a traversal slot.
  MenuNavSlot({required this.node, required this.enabled, this.label, this.onOpen, this.onClose, this.isOpen});
  /// Node focus moves to; owned by the row.
  final FocusNode node;
  /// Whether traversal may land here.
  final bool enabled;
  /// Typeahead text; null opts out of type-to-select.
  final String? label;
  /// Opens the row's nested level (ArrowRight).
  final VoidCallback? onOpen;
  /// Closes the row's nested level, if any.
  final VoidCallback? onClose;
  /// Whether the row's nested level is open.
  final bool Function()? isOpen;
}
```
