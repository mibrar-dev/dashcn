---
title: "Class: DrawerRouteTheme"
description: "The resolved surface the panel shell paints."
---

```dart
/// The resolved surface the panel shell paints.
///
/// Implemented by the component's `DrawerTheme`; the shell resolves it live on
/// every build so a light/dark or preset switch restyles an open panel.
abstract class DrawerRouteTheme {
  /// Panel fill.
  ThemedColor? get background;
  /// Panel content colour.
  ThemedColor? get foreground;
  /// Inner-edge border colour.
  ThemedColor? get borderColor;
  /// Border width.
  double? get borderWidth;
  /// Inner-corner radius.
  BorderRadius? get borderRadius;
  /// Panel padding.
  EdgeInsetsGeometry? get padding;
  /// Barrier colour.
  ThemedColor? get barrierColor;
  /// Panel extent along its slide axis.
  double? get maxSize;
  /// Whether the drag handle is drawn.
  bool? get showDragHandle;
  /// Drag handle size.
  Size? get dragHandleSize;
  /// Drag handle colour.
  ThemedColor? get dragHandleColor;
  /// Open/close transition duration.
  Duration? get transitionDuration;
  /// Drop shadows.
  List<BoxShadow>? get shadows;
  /// Ambient shadow-scale override carried by the component theme.
  ShadowScale? get themeShadows;
}
```
