---
title: "Mixin: ComponentLocalizationsForm"
description: "Form, validation and input text for [ComponentLocalizations]."
---

```dart
/// Form, validation and input text for [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsForm {
  /// Accessible label of a token chip's remove button.
  ///
  /// Copied from Flutter's `deleteButtonTooltip`, documented there as "the
  /// tooltip for the delete button of chips".
  String get chipInputRemoveChip;
  String get formNotEmpty;
  String formLessThan(Object? value);
  String formGreaterThan(Object? value);
  String formLessThanOrEqualTo(Object? value);
  String formGreaterThanOrEqualTo(Object? value);
  String formEqualTo(Object? value);
  String formBetweenInclusively(Object? min, Object? max);
  String formBetweenExclusively(Object? min, Object? max);
  String formLengthLessThan(int limit);
  String formLengthGreaterThan(int limit);
  String get formPasswordDigits;
  String get formPasswordLowercase;
  String get formPasswordUppercase;
  String get formPasswordSpecial;
  String get formPhoneNumberInvalid;
  String get formPhoneNumberEmpty;
  String get invalidValue;
  String get invalidEmail;
  String get invalidURL;
}
```
