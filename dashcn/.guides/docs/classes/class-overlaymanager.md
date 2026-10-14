---
title: "Class: OverlayManager"
description: "App-level overlay stack."
---

```dart
/// App-level overlay stack.
///
/// `OverlayManager.of(context)` finds the nearest manager installed in the
/// widget tree and returns a per-widget fallback when the app did not install
/// one (see [AppLayer]). There is deliberately no global registry: a layer
/// is only visible to the subtree it wraps.
abstract class OverlayManager implements OverlayHandler {
  /// The nearest manager installed in the tree.
  ///
  /// When no manager is in scope, warns once (debug only) and returns a
  /// per-widget fallback manager.
  static OverlayManager of(BuildContext context);
  OverlayCompleter<T?> show<T>({required BuildContext context, required WidgetBuilder builder, AlignmentGeometry alignment = Alignment.center, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
  /// Shows a tooltip overlay (same shape as [show]).
  OverlayCompleter<T?> showTooltip<T>({required BuildContext context, required WidgetBuilder builder, AlignmentGeometry alignment = Alignment.center, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
  /// Shows a menu overlay (same shape as [show]).
  OverlayCompleter<T?> showMenu<T>({required BuildContext context, required WidgetBuilder builder, AlignmentGeometry alignment = Alignment.center, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
