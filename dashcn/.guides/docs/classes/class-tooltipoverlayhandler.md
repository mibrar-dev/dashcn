---
title: "Class: TooltipOverlayHandler"
description: "Presents every overlay kind through an [OverlayManager]'s tooltip route."
---

```dart
/// Presents every overlay kind through an [OverlayManager]'s tooltip route.
///
/// The manager interface splits `show`, `showTooltip` and `showMenu` so an app
/// can style each kind separately; this adapter is what a component needs to
/// reach the tooltip route from [showPopover].
class TooltipOverlayHandler extends OverlayHandler {
  /// The manager every presentation is delegated to.
  final OverlayManager manager;
  /// Creates a tooltip overlay handler.
  const TooltipOverlayHandler(this.manager);
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
