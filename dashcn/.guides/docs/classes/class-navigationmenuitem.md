---
title: "Class: NavigationMenuItem"
description: "One menu entry: action button, content trigger, or both."
---

```dart
/// One menu entry: action button, content trigger, or both.
class NavigationMenuItem extends StatefulWidget {
  const NavigationMenuItem({super.key, this.onPressed, this.content, required this.child});
  final VoidCallback? onPressed;
  final Widget? content;
  final Widget child;
  State<NavigationMenuItem> createState();
}
```
