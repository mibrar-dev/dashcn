---
title: "Class: ErrorReporter"
description: "Hook point for analytics / crash reporting."
---

```dart
/// Hook point for analytics / crash reporting.
abstract class ErrorReporter {
  /// Reports a mapped error.
  void report(AppError appError, Object error, StackTrace stackTrace);
}
```
