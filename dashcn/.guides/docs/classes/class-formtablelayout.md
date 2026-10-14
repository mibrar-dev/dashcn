---
title: "Class: FormTableLayout"
description: "A two-column table of labelled fields."
---

```dart
/// A two-column table of labelled fields.
class FormTableLayout extends StatelessWidget {
  const FormTableLayout({super.key, required this.rows, this.spacing, this.theme});
  final List<FormItem<Object?>> rows;
  final double? spacing;
  final FormTheme? theme;
  Widget build(BuildContext context);
}
```
