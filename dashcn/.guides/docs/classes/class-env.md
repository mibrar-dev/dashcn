---
title: "Class: Env"
description: "Compile-time flags for the error handling primitive."
---

```dart
/// Compile-time flags for the error handling primitive.
class Env {
  /// Whether [AppError.technicalDetails] is attached by the built-in rules.
  /// Set with `--dart-define=DASHCN_SHOW_TECHNICAL_ERRORS=true`.
  static bool showTechnicalDetails;
}
```
