---
title: "Class: LiteralColor"
description: "A fixed color."
---

```dart
/// A fixed color. Ignores preset switches.
class LiteralColor extends ThemedColor {
  const LiteralColor(this.color);
  final Color color;
  Color resolve(ThemeColors colors);
  bool operator ==(Object other);
  int get hashCode;
}
```
