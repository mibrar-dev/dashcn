---
title: "Class: NotEmptyValidator"
description: "Fails when a string is null or empty."
---

```dart
/// Fails when a string is null or empty.
class NotEmptyValidator extends NonNullValidator<String> {
  /// Creates a non-empty validator.
  const NotEmptyValidator({super.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
