---
title: "Class: PhoneNumber"
description: "An international phone number: a country (nullable while unknown) and the  national number without the country code."
---

```dart
/// An international phone number: a country (nullable while unknown) and the
/// national number without the country code.
class PhoneNumber {
  /// The country associated with this number; null when undetected.
  final Country? country;
  /// The number without the country code.
  final String number;
  /// Creates a [PhoneNumber].
  const PhoneNumber(this.country, this.number);
  /// Returns a copy with a different [country].
  PhoneNumber withCountry(Country? country);
  /// The dial code followed by the number, or just the number when the
  /// country is unknown.
  String get fullNumber;
  /// Like [fullNumber] but always prefixed with a single `+`.
  String get fullCodeNumber;
  /// The full number, or null when the number is empty or the country is
  /// unknown.
  String? get value;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
