---
title: "Class: DrawerPanelScope"
description: "Marks the subtree as living inside a drawer panel and carries its edge."
---

```dart
/// Marks the subtree as living inside a drawer panel and carries its edge.
class DrawerPanelScope extends InheritedWidget {
  /// Creates a panel scope.
  const DrawerPanelScope({super.key, required this.position, required super.child});
  /// The physical edge the panel is anchored to.
  final OverlayPosition position;
  /// The nearest panel scope, or null.
  static DrawerPanelScope? maybeOf(BuildContext context);
  bool updateShouldNotify(DrawerPanelScope oldWidget);
}
```
