---
title: "Class: AnimationQueueController"
description: "Plays [AnimationRequest]s in order and exposes the current value."
---

```dart
/// Plays [AnimationRequest]s in order and exposes the current value.
///
/// `push(request)` queues (or replaces, when `queue` is false) a request;
/// `tick(delta)` advances the current animation by [delta].
class AnimationQueueController extends ChangeNotifier {
  /// Creates a controller with an optional [initialValue].
  AnimationQueueController([this._value = 0.0]);
  /// Adds [request] to the queue, or replaces the queue when [queue] is
  /// false.
  void push(AnimationRequest request, [bool queue = true]);
  /// Sets the value immediately and clears queued animations.
  set value(double value);
  /// The current value.
  double get value;
  /// Whether there are pending animations to tick.
  bool get shouldTick;
  /// Advances the animation by [delta].
  void tick(Duration delta);
}
```
