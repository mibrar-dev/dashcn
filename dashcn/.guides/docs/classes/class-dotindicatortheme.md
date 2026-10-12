---
title: "Class: DotIndicatorTheme"
description: "Per-variant theme container for the `dot_indicator` component."
---

```dart
/// Per-variant theme container for the `dot_indicator` component.
class DotIndicatorTheme extends ComponentThemeData implements Mergeable<DotIndicatorTheme> {
  /// Creates a dot indicator theme.
  const DotIndicatorTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.active, this.inactive, this.spacing, this.padding, this.duration});
  /// Style of the dot at the active index.
  final DotStyle? active;
  /// Style of every other dot.
  final DotStyle? inactive;
  /// Gap between two dots; null resolves `8 * scaling`.
  final double? spacing;
  /// Padding around the run of dots; null resolves [dotIndicatorDefaultPadding]
  /// (upstream `p-2`, density-scaled).
  final EdgeInsetsGeometry? padding;
  /// Duration of the active/inactive morph; null resolves 150 ms.
  final Duration? duration;
  /// The slice for the row at [index].
  DotStyle? forIndex(bool isActive);
  /// Returns a copy with the given fields replaced.
  DotIndicatorTheme copyWith({ValueGetter<DotStyle?>? active, ValueGetter<DotStyle?>? inactive, ValueGetter<double?>? spacing, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Duration?>? duration});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DotIndicatorTheme merge(DotIndicatorTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static DotIndicatorTheme lerp(DotIndicatorTheme a, DotIndicatorTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
