---
title: "Class: ErrorMapper"
description: "Converts any thrown error into an [AppError]."
---

```dart
/// Converts any thrown error into an [AppError].
abstract class ErrorMapper {
  /// Maps [error] to an [AppError].
  AppError map(Object error, [StackTrace? stackTrace]);
}
```
