---
title: "Class: Account01PasswordData"
description: "Values submitted by the [Account01PasswordForm] password form."
---

```dart
/// Values submitted by the [Account01PasswordForm] password form.
class Account01PasswordData {
  /// Creates the submitted values.
  const Account01PasswordData({required this.currentPassword, required this.newPassword});
  /// The current password.
  final String currentPassword;
  /// The validated new password.
  final String newPassword;
}
```
