---
title: "Class: DrawerPanelSurface"
description: "Paints a drawer/sheet panel around [child] from [theme]."
---

```dart
/// Paints a drawer/sheet panel around [child] from [theme].
class DrawerPanelSurface extends StatelessWidget {
  /// Creates a panel surface.
  const DrawerPanelSurface({super.key, required this.position, required this.theme, required this.child, this.showDragHandle = true, this.borderRadius});
  /// Physical edge the panel is anchored to.
  final OverlayPosition position;
  /// Resolved panel style (`DrawerTheme` implements [DrawerRouteTheme]).
  final DrawerRouteTheme theme;
  /// Panel content.
  final Widget child;
  /// Whether the drag handle is drawn.
  final bool showDragHandle;
  /// Widget-leg radius override; null falls back to [theme].
  final BorderRadius? borderRadius;
  Widget build(BuildContext context);
}
```
