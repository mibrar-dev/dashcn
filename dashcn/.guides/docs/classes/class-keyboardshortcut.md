---
title: "Class: KeyboardShortcut"
description: "A whole shortcut chord, drawn as a row of caps."
---

```dart
/// A whole shortcut chord, drawn as a row of caps.
///
/// ```dart
/// KeyboardShortcut.fromActivator(
///   activator: const SingleActivator(LogicalKeyboardKey.keyK, meta: true),
/// )
/// ```
class KeyboardShortcut extends StatelessWidget {
  /// Creates a chord from explicit keys, in the order they are shown.
  const KeyboardShortcut({super.key, required List<LogicalKeyboardKey> this._keys, this.spacing, this.theme});
  /// Creates a chord from a [ShortcutActivator], modifiers first.
  const KeyboardShortcut.fromActivator({super.key, required ShortcutActivator this._activator, this.spacing, this.theme});
  /// Horizontal gap between caps; null resolves the theme's.
  final double? spacing;
  /// Widget-leg style override, applied to every cap.
  final KeyboardShortcutTheme? theme;
  Widget build(BuildContext context);
}
```
