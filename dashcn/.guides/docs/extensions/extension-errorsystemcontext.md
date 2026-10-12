---
title: "Extension: ErrorSystemContext"
description: "Reference for extension"
---

```dart
extension ErrorSystemContext on BuildContext {
  /// Opens [showErrorDialog] for [error].
  Future<T?> showErrorDialog<T>(AppError error, {bool barrierDismissible = true});
  /// Shows a toast for [error].
  String showErrorSnackbar(AppError error, {Duration? duration});
}
```
