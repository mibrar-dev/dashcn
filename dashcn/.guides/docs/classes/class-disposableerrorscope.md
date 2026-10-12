---
title: "Class: DisposableErrorScope"
description: "An [ErrorScope] that owns its channel."
---

```dart
/// An [ErrorScope] that owns its channel.
abstract class DisposableErrorScope implements ErrorScope {
  /// Disposes the channel.
  void dispose();
}
```
