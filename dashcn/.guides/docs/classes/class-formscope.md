---
title: "Class: FormScope"
description: "Provides form state and installs [onSubmit] on the controller."
---

```dart
/// Provides form state and installs [onSubmit] on the controller.
class FormScope extends StatefulWidget {
  const FormScope({super.key, required this.child, this.controller, this.onSubmit});
  /// The subtree containing the form fields.
  final Widget child;
  /// External controller; a private one is created and disposed when null.
  final FormController? controller;
  /// Called by `FormController.submit` after a successful validation.
  final FormSubmitCallback? onSubmit;
  /// The nearest controller, or null outside a form.
  static FormController? maybeOf(BuildContext context);
  /// The nearest controller; asserts outside a form.
  static FormController of(BuildContext context);
  State<FormScope> createState();
}
```
