---
title: "Class: StarRatingTheme"
description: "Theme container for the star rating component."
---

```dart
/// Theme container for the star rating component.
class StarRatingTheme extends ComponentThemeData implements Mergeable<StarRatingTheme> {
  /// Creates a star rating theme.
  const StarRatingTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.style});
  /// The star appearance slice; null in a leg that does not restyle stars.
  final StarRatingStyle? style;
  /// Returns a copy with the given field replaced.
  StarRatingTheme copyWith({ValueGetter<StarRatingStyle?>? style});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StarRatingTheme merge(StarRatingTheme? fallback);
  /// Lerps each field; the colour reference steps at t < 0.5.
  static StarRatingTheme lerp(StarRatingTheme a, StarRatingTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
