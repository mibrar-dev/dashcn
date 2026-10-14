---
title: "Class: AnimatedValueBuilder"
description: "Animates towards [value] with [duration]/[curve] and rebuilds through  [builder]."
---

```dart
/// Animates towards [value] with [duration]/[curve] and rebuilds through
/// [builder].
///
/// When [lerp] is null, `num`, [Color], [Offset], [Size], [Rect],
/// [EdgeInsets], [BorderRadius] and [Matrix4] values are interpolated with
/// their native lerp; other types step at the midpoint.
class AnimatedValueBuilder<T> extends StatefulWidget {
  /// The target value.
  final T? value;
  /// Starting value used on first build. Defaults to [value].
  final T? initialValue;
  /// Animation duration.
  final Duration duration;
  /// Animation curve.
  final Curve curve;
  /// Custom lerp function.
  final AnimatedValueLerp<T>? lerp;
  /// Builds the widget from the current value.
  final AnimatedValueWidgetBuilder<T> builder;
  /// Passed through to [builder].
  final Widget? child;
  /// Called with the target value when an animation ends.
  final ValueChanged<T?>? onEnd;
  /// Creates an [AnimatedValueBuilder].
  const AnimatedValueBuilder({super.key, required this.value, required this.builder, this.initialValue, this.duration = Duration.zero, this.curve = Curves.linear, this.lerp, this.child, this.onEnd});
  State<AnimatedValueBuilder<T>> createState();
}
```
