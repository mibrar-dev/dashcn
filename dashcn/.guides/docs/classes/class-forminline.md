---
title: "Class: FormInline"
description: "A compact field with the label beside the input."
---

```dart
/// A compact field with the label beside the input.
class FormInline<T> extends StatelessWidget {
  const FormInline({required FormKey<T> super.key, required this.label, required this.child, this.hint, this.validator, this.showErrors, this.theme});
  FormKey<T> get key;
  final Widget label;
  final Widget child;
  final Widget? hint;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;
  final FormTheme? theme;
  Widget build(BuildContext context);
}
```
