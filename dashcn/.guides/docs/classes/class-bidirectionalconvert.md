---
title: "Class: BiDirectionalConvert"
description: "A pair of opposite conversions between [A] and [B]."
---

```dart
/// A pair of opposite conversions between [A] and [B].
class BiDirectionalConvert<A, B> {
  /// Converts from A to B.
  final Convert<A, B> aToB;
  /// Converts from B to A.
  final Convert<B, A> bToA;
  BiDirectionalConvert(this.aToB, this.bToA);
  /// Converts [value] from A to B.
  B convertA(A value);
  /// Converts [value] from B to A.
  A convertB(B value);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
