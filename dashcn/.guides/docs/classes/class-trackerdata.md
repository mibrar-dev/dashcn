---
title: "Class: TrackerData"
description: "One segment of a [Tracker]: a level (its colour) and the tooltip shown  while the pointer rests on it."
---

```dart
/// One segment of a [Tracker]: a level (its colour) and the tooltip shown
/// while the pointer rests on it.
class TrackerData {
  /// Creates a tracker segment.
  const TrackerData({required this.tooltip, required this.level});
  /// Tooltip content; the `Tooltip` component supplies the surface.
  final Widget tooltip;
  /// Activity level of this segment.
  final TrackerLevel level;
}
```
