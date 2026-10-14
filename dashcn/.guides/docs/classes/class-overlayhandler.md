---
title: "Class: OverlayHandler"
description: "Presents overlays (popover, tooltip, menu) and returns their completer."
---

```dart
/// Presents overlays (popover, tooltip, menu) and returns their completer.
abstract class OverlayHandler {
  /// Default popover overlay handler.
  static const OverlayHandler popover = PopoverOverlayHandler();
  /// Creates an [OverlayHandler].
  const OverlayHandler();
  /// Shows an overlay.
  ///
  /// See the parameter documentation on the concrete handlers; the defaults
  /// match `PopoverOverlayHandler.show`.
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
