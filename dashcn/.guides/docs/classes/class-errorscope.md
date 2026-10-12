---
title: "Class: ErrorScope"
description: "A typed handle to an error channel."
---

```dart
/// A typed handle to an error channel.
abstract class ErrorScope {
  /// The channel.
  ValueNotifier<AppError?> get notifier;
  /// Clears the channel.
  void clear();
}
```
