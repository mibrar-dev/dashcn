---
title: "Class: ApiException"
description: "Thrown by an API adapter; mapped by `apiRules`."
---

```dart
/// Thrown by an API adapter; mapped by `apiRules`.
class ApiException implements Exception {
  /// Creates an API exception.
  ApiException({required this.statusCode, this.message, this.details});
  /// HTTP-like status code.
  final int statusCode;
  /// Optional server message.
  final String? message;
  /// Optional payload.
  final Object? details;
  String toString();
}
```
