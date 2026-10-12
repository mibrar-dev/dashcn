---
title: "Class: Hover"
description: "Tracks mouse hover state and triggers delayed show/hide callbacks."
---

```dart
/// Tracks mouse hover state and triggers delayed show/hide callbacks.
class Hover extends StatefulWidget {
  /// The child tracked for hover.
  final Widget child;
  /// Delay before `onHover(true)` fires. Defaults to 300 ms.
  final Duration? waitDuration;
  /// Minimum time hover feedback stays visible. Defaults to zero.
  final Duration? minDuration;
  /// Duration added after [minDuration] before `onHover(false)` fires.
  final Duration? showDuration;
  /// Called with `true` after [waitDuration] of hovering, `false` after
  /// leaving.
  final ValueChanged<bool>? onHover;
  /// Creates a [Hover] widget.
  const Hover({super.key, required this.child, this.waitDuration, this.minDuration, this.showDuration, this.onHover});
  State<Hover> createState();
}
```
