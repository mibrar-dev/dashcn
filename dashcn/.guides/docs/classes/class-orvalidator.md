---
title: "Class: OrValidator"
description: "Passes when at least one of its validators passes."
---

```dart
/// Passes when at least one of its validators passes.
class OrValidator<T> extends Validator<T> {
  /// Creates an OR-combination of [validators].
  const OrValidator(this.validators);
  /// The validators, tried in order.
  final List<Validator<T>> validators;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
