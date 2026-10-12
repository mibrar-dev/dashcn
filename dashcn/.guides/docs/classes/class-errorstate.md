---
title: "Class: ErrorState"
description: "A full-page (or section) error surface built from `Card`, `Divider` and  `Button`."
---

```dart
/// A full-page (or section) error surface built from `Card`, `Divider` and
/// `Button`.
class ErrorState extends StatelessWidget {
  /// Creates an error state.
  const ErrorState({super.key, required this.error, this.icon, this.maxWidth, this.theme});
  /// The error to render.
  final AppError error;
  /// Replaces the default icon.
  final Widget? icon;
  /// Maximum width of the card; null resolves 520.
  final double? maxWidth;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final ErrorSystemTheme? theme;
  Widget build(BuildContext context);
}
```
