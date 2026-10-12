---
title: "Class: PopoverController"
description: "Manages a set of open popovers: show, close, update and dispose."
---

```dart
/// Manages a set of open popovers: show, close, update and dispose.
class PopoverController extends ChangeNotifier {
  /// Whether any managed popover is open and not yet completed.
  bool get hasOpenPopover;
  /// Whether any managed popover is mounted with an animation in progress.
  bool get hasMountedPopover;
  /// Unmodifiable view of the currently open popovers.
  Iterable<Popover> get openPopovers;
  /// Shows a popover and completes with its result.
  ///
  /// When [closeOthers] is true the currently open popovers are closed first.
  Future<T?> show<T>({required BuildContext context, required WidgetBuilder builder, required AlignmentGeometry alignment, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, bool modal = true, bool closeOthers = true, Offset? offset, GlobalKey<OverlayHandlerStateMixin>? key, Object? regionGroupId, AlignmentGeometry? transitionAlignment, bool consumeOutsideTaps = true, EdgeInsetsGeometry? margin, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool follow = true, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? hideDuration, OverlayBarrier? overlayBarrier, OverlayHandler? handler});
  /// Closes all managed popovers, optionally without animation.
  void close([bool immediate = false]);
  /// Schedules closure of all managed popovers for the next frame.
  void closeLater();
  /// Updates the anchor context of every open popover.
  set anchorContext(BuildContext value);
  /// Updates the alignment of every open popover.
  set alignment(AlignmentGeometry value);
  /// Updates the anchor alignment of every open popover.
  set anchorAlignment(AlignmentGeometry value);
  /// Updates the width constraint of every open popover.
  set widthConstraint(PopoverConstraint value);
  /// Updates the height constraint of every open popover.
  set heightConstraint(PopoverConstraint value);
  /// Updates the margin of every open popover.
  set margin(EdgeInsets value);
  /// Updates the follow flag of every open popover.
  set follow(bool value);
  /// Updates the offset of every open popover.
  set offset(Offset? value);
  /// Updates horizontal inversion permission of every open popover.
  set allowInvertHorizontal(bool value);
  /// Updates vertical inversion permission of every open popover.
  set allowInvertVertical(bool value);
  /// Schedules closure of all popovers (used on dispose).
  void disposePopovers();
  void dispose();
}
```
