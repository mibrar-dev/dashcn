---
title: "Class: AuthException"
description: "Thrown by an auth adapter; mapped by `authRules`."
---

```dart
/// Thrown by an auth adapter; mapped by `authRules`.
class AuthException implements Exception {
  /// Creates an auth exception.
  AuthException({this.message, this.reason});
  /// Optional message.
  final String? message;
  /// Optional reason.
  final String? reason;
  String toString();
}
```
