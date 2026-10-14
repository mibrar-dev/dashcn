---
title: "Class: DataHolder"
description: "Read-only view of a data holder: finds data of a type for a context."
---

```dart
/// Read-only view of a data holder: finds data of a type for a context.
///
/// Registration of receivers is the messenger's side of the contract and
/// lives in `data_messenger.dart`.
abstract class DataHolder<T> {
  /// Finds data of [type] among the registered receivers for [context].
  T? findData(BuildContext context, Type type);
}
```
