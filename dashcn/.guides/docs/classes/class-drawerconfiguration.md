---
title: "Class: DrawerConfiguration"
description: "Presents its content as a drawer via the `drawer` component."
---

```dart
/// Presents its content as a drawer via the `drawer` component.
class DrawerConfiguration extends OverlayConfiguration {
  const DrawerConfiguration({this.anchor, this.position = OverlayPosition.bottom, this.expands = false, this.draggable = true, this.barrierDismissible = true, this.useSafeArea = true, this.showDragHandle, this.borderRadius, this.maxSize, this.useRootNavigator = true});
  final Anchor? anchor;
  final OverlayPosition position;
  final bool expands;
  final bool draggable;
  final bool barrierDismissible;
  final bool useSafeArea;
  final bool? showDragHandle;
  final BorderRadius? borderRadius;
  final double? maxSize;
  final bool useRootNavigator;
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
