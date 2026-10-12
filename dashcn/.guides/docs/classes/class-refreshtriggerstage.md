---
title: "Class: RefreshTriggerStage"
description: "Snapshot of refresh state handed to indicator builders."
---

```dart
/// Snapshot of refresh state handed to indicator builders.
class RefreshTriggerStage {
  /// Creates a stage snapshot.
  const RefreshTriggerStage(this.stage, this.extent, this.direction, this.reverse);
  /// Current lifecycle stage.
  final TriggerStage stage;
  /// Animated pull extent (0..1 of the arming distance and beyond).
  final Animation<double> extent;
  /// Pull gesture direction.
  final Axis direction;
  /// Whether the pull direction is inverted.
  final bool reverse;
  /// Current numeric pull extent.
  double get extentValue;
}
```
