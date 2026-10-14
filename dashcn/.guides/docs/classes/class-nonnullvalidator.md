---
title: "Class: NonNullValidator"
description: "Fails when the value is null."
---

```dart
/// Fails when the value is null.
class NonNullValidator<T> extends Validator<T> {
  /// Creates a non-null validator.
  const NonNullValidator({this.message});
  /// Failure text; null uses `formNotEmpty`.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
