---
title: "Class: NavigationMenuContent"
description: "Reference for NavigationMenuContent"
---

```dart
class NavigationMenuContent extends StatelessWidget {
  const NavigationMenuContent({super.key, required this.title, this.content, this.leading, this.trailing, this.onPressed});
  final Widget title;
  final Widget? content;
  final Widget? leading;
  final Widget? trailing;
  /// Action on press (closes the menu first).
  final VoidCallback? onPressed;
  Widget build(BuildContext context);
}
```
