---
title: "Class: InheritedRootDataHolder"
description: "An inherited widget that passes the root [DataHolder] to its descendants."
---

```dart
/// An inherited widget that passes the root [DataHolder] to its descendants.
class InheritedRootDataHolder extends InheritedDataHolderWidget<dynamic> {
  final DataHolder<dynamic> holder;
  const InheritedRootDataHolder({super.key, required this.holder, required super.child});
  bool updateShouldNotify(covariant InheritedRootDataHolder oldWidget);
}
```
