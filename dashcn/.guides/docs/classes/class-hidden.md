---
title: "Class: Hidden"
description: "Collapses [child] with a fade + size animation while [hidden] is true."
---

```dart
/// Collapses [child] with a fade + size animation while [hidden] is true.
class Hidden extends StatelessWidget {
  /// Whether the child is hidden.
  final bool hidden;
  /// The child.
  final Widget child;
  /// Collapse direction. Defaults to [Axis.horizontal].
  final Axis? direction;
  /// Whether the collapse animation runs in reverse.
  final bool? reverse;
  /// Animation duration. Defaults to `kDefaultDuration`.
  final Duration? duration;
  /// Animation curve. Defaults to [Curves.easeInOut].
  final Curve? curve;
  /// Whether the cross-axis size is kept while hidden.
  final bool? keepCrossAxisSize;
  /// Whether the main-axis size is kept while hidden.
  final bool? keepMainAxisSize;
  /// Creates a [Hidden] widget.
  const Hidden({super.key, required this.hidden, required this.child, this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  Widget build(BuildContext context);
}
```
