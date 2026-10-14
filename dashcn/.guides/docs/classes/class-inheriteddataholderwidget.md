---
title: "Class: InheritedDataHolderWidget"
description: "An inherited widget that passes a [DataHolder] to its descendants."
---

```dart
/// An inherited widget that passes a [DataHolder] to its descendants.
abstract class InheritedDataHolderWidget<T> extends InheritedWidget {
  const InheritedDataHolderWidget({required super.child, super.key});
  /// The holder exposed to descendants.
  DataHolder<T> get holder;
}
```
