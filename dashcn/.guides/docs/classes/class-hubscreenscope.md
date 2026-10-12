---
title: "Class: HubScreenScope"
description: "An [ErrorScope] backed by a screen-level [AppErrorHub] channel."
---

```dart
/// An [ErrorScope] backed by a screen-level [AppErrorHub] channel.
class HubScreenScope implements DisposableErrorScope {
  /// Creates a screen scope for [key].
  HubScreenScope(this.key);
  /// Channel key.
  final String key;
  ValueNotifier<AppError?> get notifier;
  void clear();
  void dispose();
}
```
