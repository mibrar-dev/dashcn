---
title: "Class: ValidationMode"
description: "Runs the wrapped validator only during the listed [FormValidationMode]s."
---

```dart
/// Runs the wrapped validator only during the listed [FormValidationMode]s.
class ValidationMode<T> extends Validator<T> {
  /// Creates a mode-gated validator.
  const ValidationMode(this.validator, {this.mode = const <FormValidationMode>{FormValidationMode.initial, FormValidationMode.changed, FormValidationMode.submitted}});
  /// The wrapped validator.
  final Validator<T> validator;
  /// Modes during which [validator] runs.
  final Set<FormValidationMode> mode;
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey source);
  bool operator ==(Object other);
  int get hashCode;
}
```
