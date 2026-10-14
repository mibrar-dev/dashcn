---
title: "Class: EditableTextValidation"
description: "Runs a widget-leg validator against a text getter, honouring  [FormValidationMode]."
---

```dart
/// Runs a widget-leg validator against a text getter, honouring
/// [FormValidationMode].
///
/// The owner reads [errorText] at build time; call [onChanged] after text
/// changes, [validateNow] for explicit revalidation and [validateInitial] once
/// at init. Nothing here calls `setState`: the owner decides when to rebuild.
class EditableTextValidation {
  /// Creates a validation helper.
  EditableTextValidation({required this.text, this.validator, this.mode = FormValidationMode.changed});
  /// Reads the current field text.
  final String Function() text;
  /// The widget-leg validator.
  String? Function(String? value)? validator;
  /// When validation runs automatically.
  FormValidationMode mode;
  /// The last validator result, or null.
  String? errorText;
  /// Applies new widget values; clearing the validator clears the error.
  void update({required String? Function(String? value)? validator, required FormValidationMode mode});
  /// Validates once when [mode] is [FormValidationMode.initial].
  void validateInitial();
  /// Validates on a text change when [mode] is [FormValidationMode.changed].
  void onChanged();
  /// Validates immediately, regardless of [mode].
  void validateNow();
}
```
