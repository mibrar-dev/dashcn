---
title: "Class: KeyboardShortcutDisplayHandle"
description: "Wraps a [KeyboardShortcutDisplayBuilder] so components can read it from  the tree through `Data."
---

```dart
/// Wraps a [KeyboardShortcutDisplayBuilder] so components can read it from
/// the tree through `Data.of<KeyboardShortcutDisplayHandle>`.
class KeyboardShortcutDisplayHandle {
  const KeyboardShortcutDisplayHandle(this._builder);
  /// Builds a display widget for [key].
  Widget buildKeyboardDisplay(BuildContext context, LogicalKeyboardKey key);
}
```
