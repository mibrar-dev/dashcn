---
title: "Class: PinnedSheet"
description: "An in-tree sheet: slides in from [position], drags, snaps to [stages]."
---

```dart
/// An in-tree sheet: slides in from [position], drags, snaps to [stages].
///
/// Wrap [child] in a [DrawerContainer] for chrome; the sheet publishes a
/// [DrawerContainerData] ancestor for exactly that.
class PinnedSheet extends StatefulWidget {
  const PinnedSheet({super.key, this.position = OverlayPosition.bottom, required this.child, this.controller, this.stages = const [SheetStage.closed(), SheetStage.expanded()], this.initialStage, this.backdrop, this.backdropTransform, this.draggable = true, this.showDragHandle = true, this.expands = true, this.contentExpands = false, this.modal = false, this.barrierDismissible = true, this.barrierColor, this.borderRadius, this.dragHandleSize, this.constraints, this.duration = const Duration(milliseconds: 350)});
  final OverlayPosition position;
  final Widget child;
  final SheetController? controller;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final Widget? backdrop;
  final BackdropTransform? backdropTransform;
  final bool draggable;
  final bool showDragHandle;
  final bool expands;
  final bool contentExpands;
  final bool modal;
  final bool barrierDismissible;
  final ThemedColor? barrierColor;
  final BorderRadius? borderRadius;
  final Size? dragHandleSize;
  final BoxConstraints? constraints;
  final Duration duration;
  State<PinnedSheet> createState();
}
```
