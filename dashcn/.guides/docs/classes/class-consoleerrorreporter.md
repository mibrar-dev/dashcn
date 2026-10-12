---
title: "Class: ConsoleErrorReporter"
description: "An [ErrorReporter] that writes to the debug console."
---

```dart
/// An [ErrorReporter] that writes to the debug console.
class ConsoleErrorReporter implements ErrorReporter {
  void report(AppError appError, Object error, StackTrace stackTrace);
}
```
