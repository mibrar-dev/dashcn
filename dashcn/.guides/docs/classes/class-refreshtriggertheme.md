---
title: "Class: RefreshTriggerTheme"
description: "Theme of the pull-to-refresh trigger."
---

```dart
/// Theme of the pull-to-refresh trigger.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget). Extents
/// are logical pixels multiplied by the ambient scaling at resolve time.
class RefreshTriggerTheme extends ComponentThemeData implements Mergeable<RefreshTriggerTheme> {
  /// Creates a refresh trigger theme.
  const RefreshTriggerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.minExtent, this.maxExtent, this.indicatorBuilder, this.curve, this.completeDuration});
  /// Pull distance arming the refresh. Default: 75.
  final double? minExtent;
  /// Maximum pull distance. Default: 150.
  final double? maxExtent;
  /// Indicator for a [RefreshTriggerStage]; null uses the default pill.
  final RefreshIndicatorBuilder? indicatorBuilder;
  /// Animation curve for extent changes. Default: `Curves.easeOutSine`.
  final Curve? curve;
  /// How long the completion state shows. Default: 500ms.
  final Duration? completeDuration;
  /// Returns a copy with the given fields replaced.
  RefreshTriggerTheme copyWith({ValueGetter<double?>? minExtent, ValueGetter<double?>? maxExtent, ValueGetter<RefreshIndicatorBuilder?>? indicatorBuilder, ValueGetter<Curve?>? curve, ValueGetter<Duration?>? completeDuration});
  /// Receiver wins per field; [fallback] only fills null cells.
  RefreshTriggerTheme merge(RefreshTriggerTheme? fallback);
  /// Scalars interpolate; the rest steps at `t = 0.5`.
  static RefreshTriggerTheme lerp(RefreshTriggerTheme a, RefreshTriggerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
