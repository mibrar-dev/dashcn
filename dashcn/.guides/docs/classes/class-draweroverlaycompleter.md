---
title: "Class: DrawerOverlayCompleter"
description: "Handle to an open drawer: completion, removal and animation futures."
---

```dart
/// Handle to an open drawer: completion, removal and animation futures.
class DrawerOverlayCompleter<T> implements OverlayCompleter<T> {
  /// Creates a completer over a pushed route.
  DrawerOverlayCompleter(this._future, this._animation, this._remove);
  void remove();
  void dispose();
  bool get isCompleted;
  bool get isAnimationCompleted;
  Future<T?> get future;
  Future<void> get animationFuture;
}
```
