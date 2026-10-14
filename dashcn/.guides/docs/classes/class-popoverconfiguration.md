---
title: "Class: PopoverConfiguration"
description: "Presents its content as a popover."
---

```dart
/// Presents its content as a popover.
///
/// On mobile, [adaptiveConversion] maps to a bottom [DrawerConfiguration]
/// (matching upstream adaptive behaviour); there is no separate
/// `MenuConfiguration` because it was identical to this.
class PopoverConfiguration extends OverlayConfiguration {
  const PopoverConfiguration({required this.alignment, this.anchor, this.anchorAlignment, this.modal = true, this.barrierDismissable = true, this.offset, this.follow = true, this.showDuration, this.dismissDuration, this.overlayBarrier});
  final Anchor? anchor;
  final AlignmentGeometry alignment;
  final AlignmentGeometry? anchorAlignment;
  final bool modal;
  final bool barrierDismissable;
  final Offset? offset;
  final bool follow;
  final Duration? showDuration;
  final Duration? dismissDuration;
  final OverlayBarrier? overlayBarrier;
  OverlayConfiguration adaptiveConversion(BuildContext context);
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
