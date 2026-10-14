---
title: "Class: ValidationException"
description: "Thrown by a validation adapter; mapped by `validationRules`."
---

```dart
/// Thrown by a validation adapter; mapped by `validationRules`.
class ValidationException implements Exception {
  /// Creates a validation exception.
  ValidationException({this.message, this.fieldErrors = const <String, String>{}});
  /// Optional message.
  final String? message;
  /// Per-field messages.
  final Map<String, String> fieldErrors;
  String toString();
}
```
