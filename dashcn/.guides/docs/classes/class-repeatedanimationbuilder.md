---
title: "Class: RepeatedAnimationBuilder"
description: "Repeats `start -> end` and rebuilds through [builder]."
---

```dart
/// Repeats `start -> end` and rebuilds through [builder].
class RepeatedAnimationBuilder extends StatefulWidget {
  /// The value at animation progress 0.
  final double start;
  /// The value at animation progress 1.
  final double end;
  /// Duration of one cycle.
  final Duration duration;
  /// Curve applied to the cycle.
  final Curve curve;
  /// Builds the widget from the current value.
  final RepeatedAnimationWidgetBuilder builder;
  /// Passed through to [builder].
  final Widget? child;
  /// Creates a [RepeatedAnimationBuilder].
  const RepeatedAnimationBuilder({super.key, required this.start, required this.end, required this.duration, this.curve = Curves.linear, required this.builder, this.child});
  State<RepeatedAnimationBuilder> createState();
}
```
