---
title: "Class: OverlayCompleter"
description: "Handle to a presented overlay: removal, completion and animation futures."
---

```dart
/// Handle to a presented overlay: removal, completion and animation futures.
abstract class OverlayCompleter<T> {
  /// Removes the overlay from the screen.
  void remove();
  /// Disposes the overlay resources.
  void dispose();
  /// Whether the overlay result future has completed.
  bool get isCompleted;
  /// Whether the overlay animation has completed.
  bool get isAnimationCompleted;
  /// Completes with the overlay result value.
  Future<T?> get future;
  /// Completes when the overlay animation finishes.
  Future<void> get animationFuture;
}
```
