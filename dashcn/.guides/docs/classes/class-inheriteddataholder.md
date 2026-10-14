---
title: "Class: InheritedDataHolder"
description: "An inherited widget that passes a typed [DataHolder] to its descendants."
---

```dart
/// An inherited widget that passes a typed [DataHolder] to its descendants.
class InheritedDataHolder<T> extends InheritedDataHolderWidget<T> {
  final DataHolder<T> holder;
  const InheritedDataHolder({super.key, required this.holder, required super.child});
  bool updateShouldNotify(covariant InheritedDataHolder<T> oldWidget);
}
```
