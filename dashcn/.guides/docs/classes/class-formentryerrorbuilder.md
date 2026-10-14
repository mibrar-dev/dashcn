---
title: "Class: FormEntryErrorBuilder"
description: "Renders [builder] with the nearest field's validation result."
---

```dart
/// Renders [builder] with the nearest field's validation result.
///
/// [modes] filters which [FormValidationMode] a result is shown for; results
/// from other modes read as valid.
class FormEntryErrorBuilder extends StatelessWidget {
  /// Creates an error builder over the nearest field.
  const FormEntryErrorBuilder({super.key, required this.builder, this.child, this.modes});
  /// Builds the field from its validation result.
  final Widget Function(BuildContext context, ValidationResult? error, Widget? child) builder;
  /// Passed through to [builder].
  final Widget? child;
  /// Validation modes that surface the error.
  final Set<FormValidationMode>? modes;
  Widget build(BuildContext context);
}
```
