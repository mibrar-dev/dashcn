---
title: "Class: AnimatedTransitionStyle"
description: "The starting transform of an [AnimatedStyleTransition]."
---

```dart
/// The starting transform of an [AnimatedStyleTransition].
///
/// A zero/one value is a no-op: the transition only installs the transform
/// layers it needs, so a plain cross-fade allocates no extra render objects.
class AnimatedTransitionStyle {
  /// Creates a transition style.
  const AnimatedTransitionStyle({this.beginOffset = Offset.zero, this.beginScale = 1, this.beginRotation = 0, this.beginBlur = 0});
  /// Translation at progress 0, in logical pixels; the child settles at
  /// [Offset.zero].
  final Offset beginOffset;
  /// Scale at progress 0; the child settles at 1.
  final double beginScale;
  /// Rotation at progress 0, in radians; the child settles at 0.
  final double beginRotation;
  /// Blur sigma at progress 0; the child settles at 0 (no blur).
  final double beginBlur;
  bool operator ==(Object other);
  int get hashCode;
}
```
