---
title: "Class: Login01Data"
description: "Values submitted by [Login01]."
---

```dart
/// Values submitted by [Login01].
class Login01Data {
  /// Creates the submitted values.
  const Login01Data({required this.email, required this.password, required this.rememberMe});
  /// The validated email address.
  final String email;
  /// The validated password.
  final String password;
  /// Whether remember-me was checked.
  final bool rememberMe;
}
```
