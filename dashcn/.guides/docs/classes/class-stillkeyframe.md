---
title: "Class: StillKeyframe"
description: "Holds [value] — or, when omitted, the previous segment's end value — for  [duration]."
---

```dart
/// Holds [value] — or, when omitted, the previous segment's end value — for
/// [duration].
class StillKeyframe<T> implements Keyframe<T> {
  /// Creates a holding segment.
  const StillKeyframe(this.duration, [this.value]);
  /// Value to hold. Null means "hold whatever the previous segment ended at".
  final T? value;
  final Duration duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
