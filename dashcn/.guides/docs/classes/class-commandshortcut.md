---
title: "Class: CommandShortcut"
description: "A keyboard-shortcut label for a command row."
---

```dart
/// A keyboard-shortcut label for a command row.
///
/// upstream's `CommandShortcut`: extra-small type, wide tracking, muted colour,
/// right-aligned. Pass it as the `trailing` widget of a `SubFocusListItem`
/// (the expanded title pushes it to the trailing edge); keyboard-*key* visuals
/// beyond this text belong to the `keyboard_shortcut` component.
class CommandShortcut extends StatelessWidget {
  /// Creates a shortcut label, e.g. `'⌘K'` or `'Enter'`.
  const CommandShortcut({super.key, required this.label});
  /// The shortcut text.
  final String label;
  Widget build(BuildContext context);
}
```
