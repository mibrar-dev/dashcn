---
title: "Mixin: DistinctData"
description: "A mixin for data values that decide for themselves whether listeners must  rebuild when the value is replaced."
---

```dart
/// A mixin for data values that decide for themselves whether listeners must
/// rebuild when the value is replaced.
mixin DistinctData {
  /// Whether a dependent should rebuild when [oldData] is replaced by this.
  bool shouldNotify(covariant DistinctData oldData);
}
```
