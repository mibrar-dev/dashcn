---
title: "Class: FormItem"
description: "A labelled field with hint and validation message."
---

```dart
/// A labelled field with hint and validation message.
class FormItem<T> extends StatelessWidget {
  const FormItem({required FormKey<T> super.key, required this.label, required this.child, this.hint, this.leadingLabel, this.trailingLabel, this.labelAxisAlignment = MainAxisAlignment.start, this.leadingGap, this.trailingGap, this.padding = EdgeInsets.zero, this.validator, this.showErrors, this.theme});
  FormKey<T> get key;
  final Widget label;
  final Widget child;
  final Widget? hint;
  final Widget? leadingLabel;
  final Widget? trailingLabel;
  final MainAxisAlignment labelAxisAlignment;
  final double? leadingGap;
  final double? trailingGap;
  final EdgeInsetsGeometry padding;
  final Validator<T>? validator;
  final Set<FormValidationMode>? showErrors;
  final FormTheme? theme;
  Widget build(BuildContext context);
}
```
