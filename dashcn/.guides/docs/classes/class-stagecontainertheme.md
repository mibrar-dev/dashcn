---
title: "Class: StageContainerTheme"
description: "Padding and width strategy of a `StageContainer`."
---

```dart
/// Padding and width strategy of a `StageContainer`.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class StageContainerTheme extends ComponentThemeData implements Mergeable<StageContainerTheme> {
  /// Creates a stage container theme.
  const StageContainerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.breakpoint, this.padding});
  /// Width strategy; null resolves [StageBreakpoint.defaultBreakpoints].
  final StageBreakpoint? breakpoint;
  /// Base outer padding. A density-aware `EdgeInsetsDensity` resolves against
  /// the ambient container density; a plain `EdgeInsets` is used as-is.
  final EdgeInsetsGeometry? padding;
  /// Returns a copy with the given fields replaced.
  StageContainerTheme copyWith({ValueGetter<StageBreakpoint?>? breakpoint, ValueGetter<EdgeInsetsGeometry?>? padding});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StageContainerTheme merge(StageContainerTheme? fallback);
  /// Strategies step at t < 0.5; padding lerps.
  static StageContainerTheme lerp(StageContainerTheme a, StageContainerTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
