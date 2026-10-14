---
title: "Class: DrawerContainerData"
description: "The configuration for a [DrawerContainer], provided to descendants via a  [Data] widget."
---

```dart
/// The configuration for a [DrawerContainer], provided to descendants via a
/// [Data] widget.
class DrawerContainerData {
  const DrawerContainerData({required this.position, this.isSheet = false, this.expands = false, this.draggable = true, this.showDragHandle = true, this.dragHandleSize, this.borderRadius, this.padding, this.margin = EdgeInsets.zero, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, this.constraints, this.alignment, this.fadeAnimation});
  final OverlayPosition position;
  final bool isSheet;
  final bool expands;
  final bool draggable;
  final bool showDragHandle;
  final Size? dragHandleSize;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets margin;
  final Color? barrierColor;
  final double? gapBeforeDragger;
  final double? gapAfterDragger;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final Animation<double>? fadeAnimation;
  Widget build(Widget child, {double startPadding = 0, double endPadding = 0, AxisSize? crossAxisSize, double crossAxisAlignment = 0});
}
```
