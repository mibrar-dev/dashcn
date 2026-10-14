---
title: "Class: MenuRadioItem"
description: "A radio row: exactly one per group is selected on press/Enter/Space."
---

```dart
/// A radio row: exactly one per group is selected on press/Enter/Space.
class MenuRadioItem<T> extends StatelessWidget implements MenuItem {
  const MenuRadioItem({super.key, required this.value, required this.child, this.trailing, this.enabled = true, this.autoClose = true, this.theme});
  final T value;
  final Widget child;
  final Widget? trailing;
  final bool enabled;
  final bool autoClose;
  final MenuTheme? theme;
  bool get hasLeading;
  Widget build(BuildContext context);
}
```
