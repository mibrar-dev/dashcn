---
title: "Class: Validator"
description: "Base class of every field validator."
---

```dart
/// Base class of every field validator.
///
/// `&`/`+` compose with AND, `|` with OR, `~`/`-` negate. Validators that
/// depend on other fields override [shouldRevalidate].
abstract class Validator<T> {
  /// Creates a validator.
  const Validator();
  /// Runs the check; null means valid.
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  /// Whether this validator must re-run when [source] changes value.
  bool shouldRevalidate(FormKey source);
  /// AND-combines this validator with [other].
  Validator<T> combine(Validator<T> other);
  /// AND-combines this validator with [other].
  Validator<T> operator &(Validator<T> other);
  /// AND-combines this validator with [other].
  Validator<T> operator +(Validator<T> other);
  /// OR-combines this validator with [other].
  Validator<T> operator |(Validator<T> other);
  /// Negates this validator.
  Validator<T> operator ~();
  /// Negates this validator.
  Validator<T> operator -();
}
```
