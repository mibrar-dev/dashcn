---
title: "Class: PhoneNumberValidator"
description: "Fails when the number is missing, or has no country or no digits."
---

```dart
/// Fails when the number is missing, or has no country or no digits.
///
/// No format/length rule is invented: the old validator checked the same two
/// conditions.
class PhoneNumberValidator extends Validator<PhoneNumber> {
  /// Creates a phone number validator.
  const PhoneNumberValidator({this.invalidMessage, this.emptyMessage});
  /// Failure text for a country-less or empty number; null uses
  /// `formPhoneNumberInvalid`.
  final String? invalidMessage;
  /// Failure text for a null value; null uses `formPhoneNumberEmpty`.
  final String? emptyMessage;
  FutureOr<ValidationResult?> validate(BuildContext context, PhoneNumber? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
