---
title: "Enum: AppErrorCode"
description: "Severity of an [AppError]; drives the icon and border colour."
---

```dart
/// Severity of an [AppError]; drives the icon and border colour.
enum AppErrorCode {
  network,
  timeout,
  noInternet,
  sslError,
  unauthorized,
  forbidden,
  sessionExpired,
  invalidCredentials,
  notFound,
  conflict,
  validation,
  rateLimited,
  server,
  badRequest,
  cancelled,
  invalidInput,
  platformError,
  permissionDenied,
  unknown,
}
```
