---
title: "Mixin: KeyedTabChild"
description: "A [TabChild] identified by a custom key instead of its position."
---

```dart
/// A [TabChild] identified by a custom key instead of its position.
mixin KeyedTabChild<T> on TabChild {
  /// The key identifying this tab.
  T get tabKey;
}
```
