---
title: "Mixin: FormFieldHandle"
description: "The form-facing side of one field's state."
---

```dart
/// The form-facing side of one field's state.
///
/// Mixed into the `State` of every widget that participates in a form, so the
/// field can report values, be revalidated and expose its validity to the
/// nearest form.
mixin FormFieldHandle {
  /// Whether the field is still mounted.
  bool get mounted;
  /// The key identifying this field within its form.
  FormKey get formKey;
  /// Reports [value] to the form and triggers validation.
  ///
  /// Returns the validation result, or a future of it when validation is
  /// asynchronous.
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);
  /// Re-runs validation against the current value.
  FutureOr<ValidationResult?> revalidate();
  /// Listenable for the current validation state; null until validation ran.
  ValueListenable<ValidationResult?>? get validity;
}
```
