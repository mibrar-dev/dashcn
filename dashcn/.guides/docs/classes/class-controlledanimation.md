---
title: "Class: ControlledAnimation"
description: "Maps an [AnimationController]'s progress onto an animated value."
---

```dart
/// Maps an [AnimationController]'s progress onto an animated value.
///
/// [forward] animates from the current value to [to] with an optional curve;
/// setting [value] snaps without animating.
class ControlledAnimation extends Animation<double> {
  /// Creates a controlled animation over [controller].
  ControlledAnimation(this._controller);
  /// Animates from the current value to [to] with [curve].
  TickerFuture forward(double to, [Curve? curve]);
  /// Snaps to [value] without animating.
  set value(double value);
  void addListener(VoidCallback listener);
  void addStatusListener(AnimationStatusListener listener);
  void removeListener(VoidCallback listener);
  void removeStatusListener(AnimationStatusListener listener);
  AnimationStatus get status;
  double get value;
}
```
