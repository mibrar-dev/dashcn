---
title: "Class: Keyframe"
description: "One segment of a [TimelineAnimation]."
---

```dart
/// One segment of a [TimelineAnimation].
abstract class Keyframe<T> {
  /// How long this segment takes.
  Duration get duration;
  /// The value at [t] inside this segment; `t` is `0..1` within the segment.
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
