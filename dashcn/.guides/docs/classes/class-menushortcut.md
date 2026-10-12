---
title: "Class: MenuShortcut"
description: "A keyboard-shortcut hint: text-xs, widest tracking, muted, end-aligned  (compose as a row's trailing)."
---

```dart
/// A keyboard-shortcut hint: text-xs, widest tracking, muted, end-aligned
/// (compose as a row's trailing).
class MenuShortcut extends StatelessWidget {
  /// Creates a shortcut hint.
  const MenuShortcut({super.key, required this.shortcut});
  /// Hint text, e.g. '⇧⌘P'.
  final String shortcut;
  Widget build(BuildContext context);
}
```
