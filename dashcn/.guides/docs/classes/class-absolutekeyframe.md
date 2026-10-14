---
title: "Class: AbsoluteKeyframe"
description: "Animates between explicit [from] and [to] values."
---

```dart
/// Animates between explicit [from] and [to] values.
class AbsoluteKeyframe<T> implements Keyframe<T> {
  /// Creates an absolute segment: `from` -> `to` over [duration].
  const AbsoluteKeyframe(this.duration, this.from, this.to);
  /// Segment start value.
  final T from;
  /// Segment end value.
  final T to;
  final Duration duration;
  T compute(TimelineAnimation<T> timeline, int index, double t);
}
```
