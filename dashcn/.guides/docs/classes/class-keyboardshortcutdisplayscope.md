---
title: "Class: KeyboardShortcutDisplayScope"
description: "Installs an app-wide key-label builder for [child]."
---

```dart
/// Installs an app-wide key-label builder for [child].
///
/// Without one, [KeyboardKeyCap] falls back to [defaultKeyboardKeyLabel].
/// [builder] is read through [Data] so a single install covers every hint in
/// the subtree.
class KeyboardShortcutDisplayScope extends StatelessWidget {
  /// Creates the scope.
  const KeyboardShortcutDisplayScope({super.key, this.builder, required this.child});
  /// Builds the label for one key; null keeps [defaultKeyboardKeyLabel].
  final KeyboardShortcutDisplayBuilder? builder;
  /// Wraps the tree that reads the builder.
  final Widget child;
  Widget build(BuildContext context);
}
```
