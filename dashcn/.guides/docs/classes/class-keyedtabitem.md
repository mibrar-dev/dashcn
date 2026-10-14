---
title: "Class: KeyedTabItem"
description: "A [TabItem] carrying a custom [tabKey]."
---

```dart
/// A [TabItem] carrying a custom [tabKey].
class KeyedTabItem<T> extends TabItem with KeyedTabChild<T> {
  /// Creates a keyed tab item.
  KeyedTabItem({required T key, required super.child});
  ValueKey<T> get key;
  T get tabKey;
}
```
