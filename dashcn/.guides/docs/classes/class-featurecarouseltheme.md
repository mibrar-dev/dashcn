---
title: "Class: FeatureCarouselTheme"
description: "Appearance of the feature carousel."
---

```dart
/// Appearance of the feature carousel.
class FeatureCarouselTheme extends ComponentThemeData implements Mergeable<FeatureCarouselTheme> {
  /// Creates a feature carousel theme.
  const FeatureCarouselTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.cardFill, this.cardBorder, this.ghostFill, this.controlBackground, this.controlForeground, this.accentColor, this.radius, this.transitionDuration});
  final ThemedColor? cardFill;
  /// Border of the centre card; the ghost cards derive theirs from it.
  final ThemedColor? cardBorder;
  final ThemedColor? ghostFill;
  final ThemedColor? controlBackground;
  final ThemedColor? controlForeground;
  final ThemedColor? accentColor;
  final double? radius;
  final Duration? transitionDuration;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  FeatureCarouselTheme merge(FeatureCarouselTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
