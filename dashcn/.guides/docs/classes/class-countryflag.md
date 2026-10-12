---
title: "Class: CountryFlag"
description: "Flag tile for a country."
---

```dart
/// Flag tile for a country.
///
/// Unknown codes render as an empty box of the requested size, keeping the
/// surrounding layout intact. With no theme builder, flags draw as Unicode
/// regional-indicator emoji (no assets, no extra dependency); provide
/// [CountryFlagTheme.builder] for real artwork.
class CountryFlag extends StatelessWidget {
  /// Creates a flag for [country] (null renders an empty box).
  const CountryFlag(this.country, {super.key, this.width, this.height, this.shape, this.theme});
  /// Creates a flag from an ISO 3166-1 alpha-2 code (e.g. `US`).
  CountryFlag.fromCountryCode(String countryCode, {super.key, this.width, this.height, this.shape, this.theme});
  /// Creates a flag from an ISO 4217 currency code (e.g. `USD`); the first
  /// table match wins when countries share a currency.
  CountryFlag.fromCurrencyCode(String currencyCode, {super.key, this.width, this.height, this.shape, this.theme});
  /// Creates a flag from an international dial code (e.g. `+81`); the first
  /// table match wins when countries share a prefix.
  CountryFlag.fromPhonePrefix(String prefix, {super.key, this.width, this.height, this.shape, this.theme});
  /// Draws [details] as a regional-indicator emoji pair, scaled to fit.
  ///
  /// This is the default artwork and stays public so custom builders can
  /// defer to it for uncovered countries.
  static Widget emojiBuilder(BuildContext context, CountryFlagDetails details);
  /// Country to draw, or null for an empty box.
  final Country? country;
  /// Flag width override; null falls back to the theme (24, scaled).
  final double? width;
  /// Flag height override; null falls back to the theme (18, scaled).
  final double? height;
  /// Clip shape override; null falls back to the theme (unclipped).
  final ShapeBorder? shape;
  /// Widget-leg theme override, merged over the other legs.
  final CountryFlagTheme? theme;
  Widget build(BuildContext context);
}
```
