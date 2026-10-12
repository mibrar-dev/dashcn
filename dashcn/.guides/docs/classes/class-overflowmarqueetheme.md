---
title: "Class: OverflowMarqueeTheme"
description: "Direction, timing and edge fade of one marquee."
---

```dart
/// Direction, timing and edge fade of one marquee.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class OverflowMarqueeTheme extends ComponentThemeData implements Mergeable<OverflowMarqueeTheme> {
  /// Creates a marquee theme.
  const OverflowMarqueeTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.direction, this.duration, this.delayDuration, this.step, this.fadePortion, this.curve});
  /// Scroll axis; null resolves `Axis.horizontal`.
  final Axis? direction;
  /// Time of one `step` run; null resolves `1s`.
  final Duration? duration;
  /// Pause at each end of a run; null resolves `500ms`.
  final Duration? delayDuration;
  /// Pixels per [duration]; null resolves `100`.
  final double? step;
  /// Edge fade as a fraction of the visible extent; null resolves `0.1`.
  final double? fadePortion;
  /// Easing of each run; null resolves `Curves.linear`.
  final Curve? curve;
  /// Returns a copy with the given fields replaced.
  OverflowMarqueeTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<Duration?>? duration, ValueGetter<Duration?>? delayDuration, ValueGetter<double?>? step, ValueGetter<double?>? fadePortion, ValueGetter<Curve?>? curve});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  OverflowMarqueeTheme merge(OverflowMarqueeTheme? fallback);
  /// Discrete values step at t < 0.5; scalars are lerped.
  static OverflowMarqueeTheme lerp(OverflowMarqueeTheme a, OverflowMarqueeTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
