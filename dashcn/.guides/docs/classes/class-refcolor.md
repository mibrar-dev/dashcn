---
title: "Class: RefColor"
description: "A token reference with an alpha multiplier."
---

```dart
/// A token reference with an alpha multiplier. Alpha multiplies (never
/// replaces) the token's own alpha, so alpha-bearing tokens such as a
/// 10%-alpha dark border stay correct.
class RefColor extends ThemedColor {
  const RefColor(this.ref, {this.alpha = 1.0});
  final ColorRef ref;
  final double alpha;
  Color resolve(ThemeColors colors);
  bool operator ==(Object other);
  int get hashCode;
}
```
