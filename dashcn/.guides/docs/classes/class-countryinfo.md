---
title: "Class: CountryInfo"
description: "One row of the [countryTable]: display name, ISO code, dial code and  ISO 4217 currency code for a country."
---

```dart
/// One row of the [countryTable]: display name, ISO code, dial code and
/// ISO 4217 currency code for a country.
class CountryInfo {
  /// Creates a country info row.
  const CountryInfo(this.code, this.dialCode, this.currencyCode, this.name, {this.primary = false});
  /// ISO 3166-1 alpha-2 code, e.g. `US`.
  final String code;
  /// International dial code with `+` prefix, e.g. `+1`.
  final String dialCode;
  /// ISO 4217 currency code, e.g. `USD`.
  final String currencyCode;
  /// English display name, e.g. `United States`.
  final String name;
  /// Whether this row is the primary country of a shared dial code.
  ///
  /// Typed-prefix detection uses it as the tie-break between rows that share
  /// a dial code (`+1` → `US`, `+44` → `GB`, `+590` → `GP`, ...); a current
  /// selection sharing the code still wins.
  final bool primary;
  /// This row as the minimal [Country] value type.
  Country get country;
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
