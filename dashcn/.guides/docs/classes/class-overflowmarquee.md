---
title: "Class: OverflowMarquee"
description: "Scrolls [child] along [direction] when it overflows its container and  stays still when it fits."
---

```dart
/// Scrolls [child] along [direction] when it overflows its container and
/// stays still when it fits. The scroll ping-pongs — rest, one run of the
/// overflow, rest, back — with fades at both clipped edges; under reduced
/// motion (`MediaQuery.disableAnimations`) the content holds its position.
class OverflowMarquee extends StatefulWidget {
  /// Creates a marquee.
  const OverflowMarquee({super.key, required this.child, this.direction, this.duration, this.delayDuration, this.step, this.fadePortion, this.curve, this.theme});
  /// Content to scroll.
  final Widget child;
  /// Scroll axis; null uses the theme, then `Axis.horizontal`.
  final Axis? direction;
  /// Time one run of [step] pixels takes; a run scales with the overflow.
  final Duration? duration;
  /// Pause at each end of a run.
  final Duration? delayDuration;
  /// Pixels covered per [duration].
  final double? step;
  /// Fade width per edge as a fraction of the visible extent (`0..0.5`).
  final double? fadePortion;
  /// Easing of each run.
  final Curve? curve;
  /// Widget-leg theme override, merged on top of the other legs.
  final OverflowMarqueeTheme? theme;
  State<OverflowMarquee> createState();
}
```
