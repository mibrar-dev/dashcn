---
title: "Class: DrawerContainer"
description: "A container that takes only a [child] and reads the rest of its  configuration from an ancestor [DrawerContainerData]."
---

```dart
/// A container that takes only a [child] and reads the rest of its
/// configuration from an ancestor [DrawerContainerData].
class DrawerContainer extends StatelessWidget {
  const DrawerContainer({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size, this.alignment = 0});
  const DrawerContainer.alignStart({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  const DrawerContainer.alignCenter({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  const DrawerContainer.alignEnd({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  final Widget child;
  final double startPadding;
  final double endPadding;
  final AxisSize? size;
  final double alignment;
  Widget build(BuildContext context);
}
```
