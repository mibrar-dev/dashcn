---
title: "Class: MenuButton"
description: "An actionable menu row, optionally owning a submenu; hover focuses and  opens it, press activates [onPressed] and (with [autoClose]) dismisses."
---

```dart
/// An actionable menu row, optionally owning a submenu; hover focuses and
/// opens it, press activates [onPressed] and (with [autoClose]) dismisses.
class MenuButton extends StatefulWidget implements MenuItem {
  const MenuButton({super.key, required this.child, this.subMenu, this.onPressed, this.trailing, this.leading, this.enabled = true, this.focusNode, this.autoClose = true, this.theme});
  final Widget child;
  final List<Widget>? subMenu;
  final MenuPressedCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autoClose;
  final MenuTheme? theme;
  bool get hasLeading;
  State<MenuButton> createState();
}
```
