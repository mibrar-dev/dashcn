---
title: "Class: HubAppScope"
description: "An [ErrorScope] backed by an app-level [AppErrorHub] channel."
---

```dart
/// An [ErrorScope] backed by an app-level [AppErrorHub] channel.
class HubAppScope implements ErrorScope {
  /// Creates an app scope for [key].
  HubAppScope(this.key);
  /// Channel key.
  final String key;
  ValueNotifier<AppError?> get notifier;
  void clear();
}
```
