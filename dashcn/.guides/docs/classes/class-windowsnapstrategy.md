---
title: "Class: WindowSnapStrategy"
description: "Relative target a dragged window snaps to."
---

```dart
/// Relative target a dragged window snaps to.
class WindowSnapStrategy {
  /// Creates a snap strategy.
  const WindowSnapStrategy({required this.relativeBounds, this.shouldMinifyWindow = true});
  /// Target region in 0..1 navigator coordinates (e.g. left half).
  final Rect relativeBounds;
  /// Whether the window shrinks while hovering this target.
  final bool shouldMinifyWindow;
}
```
