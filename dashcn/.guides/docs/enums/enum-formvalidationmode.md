---
title: "Enum: FormValidationMode"
description: "When a form field runs its validation."
---

```dart
/// When a form field runs its validation.
enum FormValidationMode {
  /// Validation runs when the field is created or initialized.
  ///
  /// Useful for fields with defaults that should be checked immediately.
  initial,
  /// Validation runs after every value change.
  ///
  /// The common choice: immediate feedback while the user types.
  changed,
  /// Validation is deferred until the form is submitted.
  ///
  /// Reduces interruption for expensive checks.
  submitted,
}
```
