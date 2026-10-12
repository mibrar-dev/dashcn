---
title: "Class: MenuCheckboxItem"
description: "A checkable row: toggles on press and on Enter/Space; stays open."
---

```dart
/// A checkable row: toggles on press and on Enter/Space; stays open.
class MenuCheckboxItem extends StatelessWidget implements MenuItem {
  const MenuCheckboxItem({super.key, required this.child, required this.value, required this.onChanged, this.trailing, this.enabled = true, this.autoClose = false, this.theme});
  final Widget child;
  final bool value;
  final MenuChangedCallback<bool>? onChanged;
  final Widget? trailing;
  final bool enabled;
  final bool autoClose;
  final MenuTheme? theme;
  bool get hasLeading;
  Widget build(BuildContext context);
}
```
