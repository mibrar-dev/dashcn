---
title: "Class: ToastSlot"
description: "The identity of a toast slot."
---

```dart
/// The identity of a toast slot.
///
/// Two toasts share a slot when their placement matches, so `singlePerSlot`
/// can replace rather than accumulate.
class ToastSlot {
  /// Creates a slot.
  const ToastSlot(this.placement);
  /// The placement this slot is anchored at.
  final ToastPlacement placement;
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
