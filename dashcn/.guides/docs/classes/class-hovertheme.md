---
title: "Class: HoverTheme"
description: "Timing and hit-test configuration for the hover primitives."
---

```dart
/// Timing and hit-test configuration for the hover primitives.
class HoverTheme extends ComponentThemeData implements Mergeable<HoverTheme> {
  /// Debounce duration for repeated hover events.
  final Duration? debounceDuration;
  /// Hit-test behavior used by [HoverActivity].
  final HitTestBehavior? hitTestBehavior;
  /// Delay before hover feedback is shown.
  final Duration? waitDuration;
  /// Minimum time hover feedback stays visible after leaving.
  final Duration? minDuration;
  /// Duration of the hide animation after [minDuration].
  final Duration? showDuration;
  /// Creates a [HoverTheme].
  const HoverTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.debounceDuration, this.hitTestBehavior, this.waitDuration, this.minDuration, this.showDuration});
  /// Returns a copy with the given fields replaced.
  HoverTheme copyWith({ValueGetter<Duration?>? debounceDuration, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<Duration?>? waitDuration, ValueGetter<Duration?>? minDuration, ValueGetter<Duration?>? showDuration});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  HoverTheme merge(HoverTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
