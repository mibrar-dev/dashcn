---
title: "Class: DrawerRawContainer"
description: "The visual chrome of a drawer or sheet: background, edge border, rounded  outer corners, an optional drag handle and an optional barrier wash."
---

```dart
/// The visual chrome of a drawer or sheet: background, edge border, rounded
/// outer corners, an optional drag handle and an optional barrier wash.
///
/// The drag *gesture* is intentionally not owned here — callers wrap this
/// container in their own gesture detector.
class DrawerRawContainer extends StatelessWidget {
  const DrawerRawContainer({super.key, required this.position, required this.child, this.isSheet = false, this.expands = false, this.draggable = true, this.showDragHandle = true, this.dragHandleSize, this.borderRadius, this.padding, this.margin = EdgeInsets.zero, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, this.constraints, this.alignment, this.fadeAnimation, this.crossAxisSize, this.crossAxisAlignment = 0, this.startPadding = 0, this.endPadding = 0});
  final OverlayPosition position;
  final Widget child;
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
  final AxisSize? crossAxisSize;
  final double crossAxisAlignment;
  final double startPadding;
  final double endPadding;
  Widget build(BuildContext context);
}
```
