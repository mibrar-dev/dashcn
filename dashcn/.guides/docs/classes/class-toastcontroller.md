---
title: "Class: ToastController"
description: "Owns a toast stack and exposes a small `show` surface over [ToastQueue]."
---

```dart
/// Owns a toast stack and exposes a small `show` surface over [ToastQueue].
class ToastController extends ToastQueue<ToastBuilder> {
  /// Creates a controller.
  ToastController({super.defaultDuration = const Duration(seconds: 3), super.singlePerSlot = true});
  /// Shows a toast and returns its id.
  String showToast({required ToastBuilder builder, ToastPlacement placement = ToastPlacement.bottomTrailing, Duration? duration, bool autoDismiss = true, String? id, VoidCallback? onDismissed});
}
```
