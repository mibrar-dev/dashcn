---
title: "Class: TooltipConfiguration"
description: "Presents its content as a tooltip: a non-modal popover that never follows  on mobile."
---

```dart
/// Presents its content as a tooltip: a non-modal popover that never follows
/// on mobile.
class TooltipConfiguration extends PopoverConfiguration {
  const TooltipConfiguration({super.anchor, super.alignment = Alignment.center, super.anchorAlignment, super.offset, super.follow = true, super.showDuration, super.dismissDuration});
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```
