---
title: "Class: TextAnimateTypewriter"
description: "Typewriter reveal of newly arrived units."
---

```dart
/// Typewriter reveal of newly arrived units.
class TextAnimateTypewriter {
  const TextAnimateTypewriter({this.enabled = true, this.charsPerSecond = 48});
  /// Progressive reveal on/off; off shows the whole tail at once.
  final bool enabled;
  /// Reveal speed for newly appended units.
  final double charsPerSecond;
  bool operator ==(Object other);
  int get hashCode;
}
```
