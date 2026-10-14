---
title: "Class: LengthValidator"
description: "Bounds a string's length."
---

```dart
/// Bounds a string's length.
class LengthValidator extends Validator<String> {
  /// Creates a length validator; null bounds are not checked.
  const LengthValidator({this.min, this.max, this.message});
  /// Minimum length (inclusive).
  final int? min;
  /// Maximum length (inclusive).
  final int? max;
  /// Failure text; null uses the localized bound messages.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
