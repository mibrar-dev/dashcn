---
title: "Class: ThemedColor"
description: "A color that is either a literal or a token reference."
---

```dart
/// A color that is either a literal or a token reference.
/// Const-constructible so user-owned files stay values-only and Studio can
/// rewrite them deterministically.
class ThemedColor {
  const ThemedColor();
  factory ThemedColor.value(Color color);
  factory ThemedColor.ref(ColorRef ref, {double alpha});
  /// Resolves to a concrete color against [colors].
  Color resolve(ThemeColors colors);
}
```
