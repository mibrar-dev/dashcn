---
title: "Class: EmailValidator"
description: "Requires a string to look like an e-mail address (`local@domain."
---

```dart
/// Requires a string to look like an e-mail address (`local@domain.tld`).
class EmailValidator extends Validator<String> {
  /// Creates an e-mail validator.
  const EmailValidator({this.message});
  /// Failure text; null uses `invalidEmail`.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
