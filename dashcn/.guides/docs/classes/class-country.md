---
title: "Class: Country"
description: "ISO country descriptor for a phone number."
---

```dart
/// ISO country descriptor for a phone number.
class Country {
  /// International dial code, e.g. `+1`.
  final String dialCode;
  /// ISO 3166-1 alpha-2 country code, e.g. `US`.
  final String code;
  /// Creates a [Country].
  const Country({required this.dialCode, required this.code});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
