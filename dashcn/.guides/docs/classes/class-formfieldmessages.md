---
title: "Class: FormFieldMessages"
description: "Hint and error message below a field, used by every form layout."
---

```dart
/// Hint and error message below a field, used by every form layout.
class FormFieldMessages extends StatelessWidget {
  const FormFieldMessages({super.key, required this.spacing, required this.hintStyle, required this.messageStyle, this.hint, this.message});
  final double spacing;
  final TextStyle hintStyle;
  final TextStyle messageStyle;
  final Widget? hint;
  final String? message;
  Widget build(BuildContext context);
}
```
