---
title: "Class: TimelineAnimatable"
description: "A [TimelineAnimation] re-based onto another total duration."
---

```dart
/// A [TimelineAnimation] re-based onto another total duration.
class TimelineAnimatable<T> extends Animatable<T> {
  /// Creates a re-based view of [animation] over [duration].
  TimelineAnimatable(this.duration, this.animation);
  /// The window this view maps `0..1` onto.
  final Duration duration;
  /// The underlying timeline.
  final TimelineAnimation<T> animation;
  T transform(double t);
}
```
