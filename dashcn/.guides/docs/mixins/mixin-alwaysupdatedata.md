---
title: "Mixin: AlwaysUpdateData"
description: "A [DistinctData] that always notifies dependents when replaced."
---

```dart
/// A [DistinctData] that always notifies dependents when replaced.
mixin AlwaysUpdateData implements DistinctData {
  bool shouldNotify(covariant DistinctData oldData);
}
```
