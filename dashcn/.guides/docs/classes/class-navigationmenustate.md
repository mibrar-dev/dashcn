---
title: "Class: NavigationMenuState"
description: "State of [NavigationMenu]; items reach it for activation and closing."
---

```dart
/// State of [NavigationMenu]; items reach it for activation and closing.
class NavigationMenuState extends State<NavigationMenu> {
  static void exitGrace(NavigationMenuState menu);
  bool isActive(NavigationMenuItemState item);
  /// Opens [item]'s content (or closes when it has none).
  void openItem(NavigationMenuItemState item);
  void close();
  void dispose();
  Widget build(BuildContext context);
}
```
