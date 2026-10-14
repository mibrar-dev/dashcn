---
title: "Enum: TrackerLevel"
description: "Activity level of one tracker segment."
---

```dart
/// Activity level of one tracker segment.
///
/// Replaces the old abstract `TrackerLevel` class; its `name` getter is gone
/// (the tracker never rendered it — the caller supplies the tooltip).
enum TrackerLevel {
  fine,
  warning,
  critical,
  unknown,
}
```
