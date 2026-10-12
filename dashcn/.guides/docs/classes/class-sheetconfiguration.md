---
title: "Class: SheetConfiguration"
description: "Presents its content as a full-extent sheet via the `drawer` component."
---

```dart
/// Presents its content as a full-extent sheet via the `drawer` component.
class SheetConfiguration extends DrawerConfiguration {
  const SheetConfiguration({super.anchor, super.position = OverlayPosition.bottom, super.expands = true, super.draggable = false, super.barrierDismissible, super.useSafeArea = false, super.showDragHandle, super.borderRadius, super.maxSize, super.useRootNavigator});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
