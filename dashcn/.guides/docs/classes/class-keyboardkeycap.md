---
title: "Class: KeyboardKeyCap"
description: "One key of a shortcut chord, drawn as a small rounded cap."
---

```dart
/// One key of a shortcut chord, drawn as a small rounded cap.
class KeyboardKeyCap extends StatelessWidget {
  /// Creates a key cap.
  const KeyboardKeyCap({super.key, required this.keyboardKey, this.padding, this.background, this.foreground, this.borderRadius, this.shadows, this.theme});
  /// The key this cap stands for.
  final LogicalKeyboardKey keyboardKey;
  /// Padding inside the cap; null resolves the theme's.
  final EdgeInsetsGeometry? padding;
  /// Fill override; null resolves the theme's.
  final ThemedColor? background;
  /// Label colour override; null resolves the theme's.
  final ThemedColor? foreground;
  /// Corner radius override; null resolves the theme's.
  final BorderRadiusGeometry? borderRadius;
  /// Shadows override; null resolves the theme's (none by default).
  final List<BoxShadow>? shadows;
  /// Widget-leg style override.
  final KeyboardShortcutTheme? theme;
  Widget build(BuildContext context);
}
```
