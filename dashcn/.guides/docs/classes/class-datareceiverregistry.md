---
title: "Class: DataReceiverRegistry"
description: "Registration side of a data messenger: stores forwardable receivers so  [Data."
---

```dart
/// Registration side of a data messenger: stores forwardable receivers so
/// [Data.maybeFindMessenger] can find them from other subtrees.
abstract class DataReceiverRegistry<T> {
  /// Registers a [receiver] that provides data of type [T].
  void register(ForwardableDataState<T> receiver);
  /// Unregisters a previously registered [receiver].
  void unregister(ForwardableDataState<T> receiver);
}
```
