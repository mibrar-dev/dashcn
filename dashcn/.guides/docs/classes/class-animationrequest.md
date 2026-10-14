---
title: "Class: AnimationRequest"
description: "A single queued animation target."
---

```dart
/// A single queued animation target.
class AnimationRequest {
  /// The target value to animate to.
  final double target;
  /// Duration of the animation.
  final Duration duration;
  /// Curve applied during the animation.
  final Curve curve;
  /// Creates an animation request.
  AnimationRequest(this.target, this.duration, this.curve);
}
```
