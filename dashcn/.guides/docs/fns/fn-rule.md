---
title: "Function: rule"
description: "Builds an [ErrorRule] from a typed [build] and an optional [where] guard."
---

Signature
```dart
ErrorRule rule<T>({required AppError Function(T error, StackTrace? stackTrace) build, bool Function(T error, StackTrace? stackTrace)? where, int priority = 0});
```
