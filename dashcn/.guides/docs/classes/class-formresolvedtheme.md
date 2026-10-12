---
title: "Class: FormResolvedTheme"
description: "[FormTheme] values with token colours already resolved."
---

```dart
/// [FormTheme] values with token colours already resolved.
///
/// The form layouts resolve their theme once per field and read these styles
/// directly; keeping the resolved shape next to the theme means the widget file
/// only carries layout code.
class FormResolvedTheme {
  /// Creates a resolved theme snapshot.
  const FormResolvedTheme({required this.spacing, required this.messageSpacing, required this.labelStyle, required this.hintStyle, required this.messageStyle});
  /// Vertical gap between the label row and the control.
  final double spacing;
  /// Vertical gap between the control and its hint or error text.
  final double messageSpacing;
  /// Fully coloured label style.
  final TextStyle labelStyle;
  /// Fully coloured hint style.
  final TextStyle hintStyle;
  /// Fully coloured error-message style.
  final TextStyle messageStyle;
}
```
