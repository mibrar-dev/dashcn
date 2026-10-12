---
title: "Enum: ToastPlacement"
description: "Where a toast is anchored on screen."
---

```dart
/// Where a toast is anchored on screen.
///
/// The placement is what groups the stack: toasts shown in the same placement
/// share a slot, so `singlePerPlacement` can dismiss the previous one instead of
/// stacking a second toast on top of it.
enum ToastPlacement {
  /// Top, leading edge.
  topLeading,
  /// Horizontally centred, top.
  topCenter,
  /// Top, trailing edge.
  topTrailing,
  /// Bottom, leading edge.
  bottomLeading,
  /// Horizontally centred, bottom.
  bottomCenter,
  /// Bottom, trailing edge.
  bottomTrailing,
}
```
