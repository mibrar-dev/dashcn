---
title: "Class: HoverActivity"
description: "Reports raw mouse enter/exit and repeatedly ticks a debounce controller  while hovered (`onHover` fires on every tick)."
---

```dart
/// Reports raw mouse enter/exit and repeatedly ticks a debounce controller
/// while hovered (`onHover` fires on every tick).
class HoverActivity extends StatefulWidget {
  /// The child tracked for hover.
  final Widget child;
  /// Called on each debounce tick while hovered.
  final VoidCallback? onHover;
  /// Called when the pointer leaves.
  final VoidCallback? onExit;
  /// Called when the pointer enters.
  final VoidCallback? onEnter;
  /// Tick duration of the internal debounce controller. Defaults to 100 ms.
  final Duration? debounceDuration;
  /// Hit-test behavior. Defaults to [HitTestBehavior.deferToChild].
  final HitTestBehavior? hitTestBehavior;
  /// Creates a [HoverActivity] widget.
  const HoverActivity({super.key, required this.child, this.onHover, this.onExit, this.onEnter, this.hitTestBehavior, this.debounceDuration});
  State<HoverActivity> createState();
}
```
