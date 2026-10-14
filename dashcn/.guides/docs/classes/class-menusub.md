---
title: "Class: MenuSub"
description: "A submenu: [trigger] opens [children] on hover or ArrowRight, ArrowLeft  closes; traversal and theming match [MenuButton]."
---

```dart
/// A submenu: [trigger] opens [children] on hover or ArrowRight, ArrowLeft
/// closes; traversal and theming match [MenuButton].
class MenuSub extends StatelessWidget implements MenuItem {
  const MenuSub({super.key, required this.trigger, required this.children, this.enabled = true, this.theme});
  final Widget trigger;
  final List<Widget> children;
  final bool enabled;
  final MenuTheme? theme;
  bool get hasLeading;
  Widget build(BuildContext context);
}
```
