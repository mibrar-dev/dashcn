---
title: "Class: HiddenTheme"
description: "Direction, duration, curve and size-keeping flags of [Hidden]."
---

```dart
/// Direction, duration, curve and size-keeping flags of [Hidden].
class HiddenTheme extends ComponentThemeData implements Mergeable<HiddenTheme> {
  /// Collapse direction. Defaults to [Axis.horizontal].
  final Axis? direction;
  /// Animation duration. Defaults to `kDefaultDuration`.
  final Duration? duration;
  /// Animation curve. Defaults to [Curves.easeInOut].
  final Curve? curve;
  /// Whether the collapse animation runs in reverse.
  final bool? reverse;
  /// Whether the cross-axis size is kept while hidden.
  final bool? keepCrossAxisSize;
  /// Whether the main-axis size is kept while hidden.
  final bool? keepMainAxisSize;
  /// Creates a [HiddenTheme].
  const HiddenTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  /// Returns a copy with the given fields replaced.
  HiddenTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<bool?>? reverse, ValueGetter<bool?>? keepCrossAxisSize, ValueGetter<bool?>? keepMainAxisSize});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  HiddenTheme merge(HiddenTheme? fallback);
}
```
