---
title: "Class: CompositeValidator"
description: "Runs its validators in order and stops at the first failure."
---

```dart
/// Runs its validators in order and stops at the first failure.
class CompositeValidator<T> extends Validator<T> {
  /// Creates a composite of [validators].
  const CompositeValidator(this.validators);
  /// The validators, run in order.
  final List<Validator<T>> validators;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  Validator<T> combine(Validator<T> other);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
