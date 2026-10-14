---
title: "Class: FormPending"
description: "Renders [builder] with the form's in-flight validations."
---

```dart
/// Renders [builder] with the form's in-flight validations.
///
/// The `form_core` [FormPendingBuilder] is controller-free; this widget is the
/// controller-aware counterpart the form component owns.
class FormPending extends StatelessWidget {
  /// Creates a pending builder over the nearest form.
  const FormPending({super.key, required this.builder, this.child});
  /// Builds from the pending futures.
  final FormPendingWidgetBuilder builder;
  /// Passed through to [builder].
  final Widget? child;
  Widget build(BuildContext context);
}
```
