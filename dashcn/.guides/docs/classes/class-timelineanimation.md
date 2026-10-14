---
title: "Class: TimelineAnimation"
description: "A keyframe timeline bound to a total duration."
---

```dart
/// A keyframe timeline bound to a total duration.
///
/// ```dart
/// final timeline = TimelineAnimation<double>(keyframes: [
///   AbsoluteKeyframe(const Duration(milliseconds: 200), 0.0, 1.0),
///   StillKeyframe(const Duration(milliseconds: 100)),
///   RelativeKeyframe(const Duration(milliseconds: 300), 0.0),
/// ]);
/// ```
class TimelineAnimation<T> extends Animatable<T> {
  /// Builds a timeline from [keyframes]; every segment must be positive.
  factory TimelineAnimation({PropertyLerp<T>? lerp, required List<Keyframe<T>> keyframes});
  /// Interpolation used by absolute and relative segments.
  final PropertyLerp<T> lerp;
  /// Sum of every segment duration.
  final Duration totalDuration;
  /// The segments, in order.
  final List<Keyframe<T>> keyframes;
  /// Default interpolation: rounds for `int` endpoints, lerps any other
  /// `num`, and throws for types it cannot interpolate (the old dynamic
  /// `a + (b - a) * t` cast crashed at runtime for `T = int`).
  static T defaultLerp<T>(T a, T b, double t);
  /// Drives this timeline from [controller]; the controller's duration is
  /// used as the timeline window.
  TimelineAnimatable<T> drive(AnimationController controller);
  /// Binds the timeline to an explicit [duration].
  TimelineAnimatable<T> withTotalDuration(Duration duration);
  /// The value at normalized time [t]; inputs outside `0..1` are clamped so a
  /// controller that overshoots cannot assert or index past the timeline.
  T transform(double t);
}
```
