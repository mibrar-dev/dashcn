---
title: "Class: FormErrorBuilder"
description: "Renders [builder] with every failure in the nearest form."
---

```dart
/// Renders [builder] with every failure in the nearest form.
class FormErrorBuilder extends StatelessWidget {
  /// Creates a form-wide error builder.
  const FormErrorBuilder({super.key, required this.builder, this.child});
  /// Builds from the aggregated errors.
  final Widget Function(BuildContext context, Map<FormKey, ValidationResult> errors, Widget? child) builder;
  /// Passed through to [builder].
  final Widget? child;
  Widget build(BuildContext context);
}
```
