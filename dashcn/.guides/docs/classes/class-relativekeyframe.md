---
title: "Class: RelativeKeyframe"
description: "Animates from the previous segment's end value to [target]."
---

```dart
/// Animates from the previous segment's end value to [target].
class RelativeKeyframe<T> implements Keyframe<T> {
  /// Creates a relative segment ending at [target].
  const RelativeKeyframe(this.duration, this.target);
  /// Segment end value; the start is the previous segment's end.
  final T target;
  final Duration duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
