---
title: "Class: ValidationResult"
description: "The outcome of validating one form field."
---

```dart
/// The outcome of validating one form field.
///
/// The [state] records which [FormValidationMode] triggered the run, so
/// consumers can tell an on-submit failure from a live keystroke failure.
/// Subclasses such as `ReplaceResult` carry the payload.
abstract class ValidationResult {
  /// Creates a result produced during [state].
  const ValidationResult({required this.state});
  /// The validation mode that produced this result.
  final FormValidationMode state;
  /// The field this result belongs to.
  FormKey get key;
  /// Returns a copy of this result bound to [key].
  ValidationResult attach(FormKey key);
}
```
