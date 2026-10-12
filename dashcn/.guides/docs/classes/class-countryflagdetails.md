---
title: "Class: CountryFlagDetails"
description: "Request a [CountryFlagBuilder] answers: the country plus the box the  flag should fill."
---

```dart
/// Request a [CountryFlagBuilder] answers: the country plus the box the
/// flag should fill.
class CountryFlagDetails {
  /// Creates flag details.
  const CountryFlagDetails({required this.country, required this.width, required this.height, this.shape});
  /// Country to draw.
  final Country country;
  /// Width the flag should occupy.
  final double width;
  /// Height the flag should occupy.
  final double height;
  /// Shape to clip to; null draws unclipped.
  final ShapeBorder? shape;
  /// ISO 3166-1 alpha-2 code of [country].
  String get countryCode;
  bool operator ==(Object other);
  int get hashCode;
}
```
