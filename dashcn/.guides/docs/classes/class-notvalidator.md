---
title: "Class: NotValidator"
description: "Passes when the wrapped validator fails."
---

```dart
/// Passes when the wrapped validator fails.
class NotValidator<T> extends Validator<T> {
  /// Creates a negation of [validator].
  const NotValidator(this.validator, {this.message});
  /// The validator to negate.
  final Validator<T> validator;
  /// Failure text; null uses the localized generic message.
  final String? message;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
