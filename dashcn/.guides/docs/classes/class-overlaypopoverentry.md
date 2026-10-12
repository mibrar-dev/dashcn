---
title: "Class: OverlayPopoverEntry"
description: "[OverlayCompleter] implementation for popover overlays."
---

```dart
/// [OverlayCompleter] implementation for popover overlays.
class OverlayPopoverEntry<T> implements OverlayCompleter<T> {
  /// Completes with the popover result value.
  final Completer<T?> completer;
  /// Completes when the popover's entry/exit animation finishes.
  final Completer<T?> animationCompleter;
  bool get isCompleted;
  /// Initializes the entry with its overlay entries.
  void initialize(OverlayEntry overlayEntry, [OverlayEntry? barrierEntry]);
  void remove();
  void dispose();
  Future<T?> get future;
  Future<T?> get animationFuture;
  bool get isAnimationCompleted;
}
```
