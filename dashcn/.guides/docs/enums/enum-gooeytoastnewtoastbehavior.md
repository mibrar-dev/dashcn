---
title: "Enum: GooeyToastNewToastBehavior"
description: "Strategy when a new toast is shown in an occupied slot."
---

```dart
/// Strategy when a new toast is shown in an occupied slot.
enum GooeyToastNewToastBehavior {
  /// Adds the new toast to the same slot stack.
  stack,
  /// Removes the existing toasts in the slot first.
  dismissPrevious,
  /// Updates the newest toast in the slot in place.
  transition,
}
```
