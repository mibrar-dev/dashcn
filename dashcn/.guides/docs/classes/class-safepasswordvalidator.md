---
title: "Class: SafePasswordValidator"
description: "Checks a password against the enabled character-class requirements."
---

```dart
/// Checks a password against the enabled character-class requirements.
class SafePasswordValidator extends Validator<String> {
  /// Creates a password-strength validator.
  const SafePasswordValidator({this.requireDigit = true, this.requireLowercase = true, this.requireUppercase = true, this.requireSpecialChar = true, this.message});
  /// Whether a digit is required.
  final bool requireDigit;
  /// Whether a lowercase letter is required.
  final bool requireLowercase;
  /// Whether an uppercase letter is required.
  final bool requireUppercase;
  /// Whether a non-alphanumeric character is required.
  final bool requireSpecialChar;
  /// Overrides every message when set.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
