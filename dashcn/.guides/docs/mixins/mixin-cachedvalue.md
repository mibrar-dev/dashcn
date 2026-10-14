---
title: "Mixin: CachedValue"
description: "A value that decides whether a dependent must rebuild when it changes."
---

```dart
/// A value that decides whether a dependent must rebuild when it changes.
mixin CachedValue {
  /// Whether a cached dependent must rebuild when [oldValue] is replaced.
  bool shouldRebuild(covariant CachedValue oldValue);
}
```
