---
title: "Class: SliderTheme"
description: "Per-variant theme container for the slider component."
---

```dart
/// Per-variant theme container for the slider component.
class SliderTheme extends ComponentThemeData implements Mergeable<SliderTheme> {
  /// Creates a slider theme with one nullable slice per variant.
  const SliderTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.standard, this.soft, this.dots, this.wave});
  /// Style for [SliderVariant.standard].
  final SliderStyle? standard;
  /// Style for [SliderVariant.soft].
  final SliderStyle? soft;
  /// Style for [SliderVariant.dots].
  final SliderStyle? dots;
  /// Style for [SliderVariant.wave].
  final SliderStyle? wave;
  /// The slice for [variant], or null when this leg leaves it unset.
  SliderStyle? forVariant(SliderVariant variant);
  /// Returns a copy with the given variant rows replaced.
  SliderTheme copyWith({ValueGetter<SliderStyle?>? standard, ValueGetter<SliderStyle?>? soft, ValueGetter<SliderStyle?>? dots, ValueGetter<SliderStyle?>? wave});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  SliderTheme merge(SliderTheme? fallback);
  /// Lerps each row; state scales step at t < 0.5.
  static SliderTheme lerp(SliderTheme a, SliderTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
