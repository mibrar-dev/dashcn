---
title: "Class: ErrorHandledRepository"
description: "Base class for repositories with automatic [AppError] mapping."
---

```dart
/// Base class for repositories with automatic [AppError] mapping.
abstract class ErrorHandledRepository {
  /// Creates a repository.
  ErrorHandledRepository({required this.errorMapper, this.errorReporter});
  /// Maps raw errors to [AppError].
  final ErrorMapper errorMapper;
  /// Optional analytics hook.
  final ErrorReporter? errorReporter;
  /// Runs [operation], mapping and reporting a failure as an [AppError].
  Future<T> execute<T>(Future<T> Function() operation);
  /// The synchronous form of [execute].
  T executeSync<T>(T Function() operation);
  /// Runs [operation]; when [onError] returns a value it wins, otherwise the
  /// mapped [AppError] is reported and rethrown.
  Future<T> executeWithHandler<T>({required Future<T> Function() operation, required T? Function(Object error) onError});
}
```
