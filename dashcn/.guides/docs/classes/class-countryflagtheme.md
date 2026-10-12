---
title: "Class: CountryFlagTheme"
description: "Theme of the country flag tile."
---

```dart
/// Theme of the country flag tile.
///
/// Every field is nullable: `null` means "inherit", and the resolver fills
/// the gap from the next leg (defaults < app < scoped < widget).
class CountryFlagTheme extends ComponentThemeData implements Mergeable<CountryFlagTheme> {
  /// Creates a country flag theme.
  const CountryFlagTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.builder, this.width, this.height, this.shape});
  /// Artwork provider; null uses the built-in emoji fallback.
  final CountryFlagBuilder? builder;
  /// Default flag width. Default: 24 (scaled).
  final double? width;
  /// Default flag height. Default: 18 (scaled).
  final double? height;
  /// Default clip shape; null draws unclipped.
  final ShapeBorder? shape;
  /// Returns a copy with the given fields replaced.
  CountryFlagTheme copyWith({ValueGetter<CountryFlagBuilder?>? builder, ValueGetter<double?>? width, ValueGetter<double?>? height, ValueGetter<ShapeBorder?>? shape});
  /// Receiver wins per field; [fallback] only fills null cells.
  CountryFlagTheme merge(CountryFlagTheme? fallback);
  /// Geometry interpolates; the rest steps at `t = 0.5`.
  static CountryFlagTheme lerp(CountryFlagTheme a, CountryFlagTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```
