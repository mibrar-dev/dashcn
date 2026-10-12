---
title: "Class: NavigationMenu"
description: "Horizontal bar of entries with dropdown content."
---

```dart
/// Horizontal bar of entries with dropdown content.
class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, this.surfaceOpacity, this.surfaceBlur, required this.children, this.theme});
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final List<Widget> children;
  /// Widget-leg theme override, merged over the other legs.
  final NavigationMenuTheme? theme;
  State<NavigationMenu> createState();
}
```
