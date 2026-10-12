---
title: "Class: TextAnimateCursor"
description: "Cursor shown while streaming."
---

```dart
/// Cursor shown while streaming.
class TextAnimateCursor {
  const TextAnimateCursor.none();
  const TextAnimateCursor.blink({this.character = '|', this.blinkPeriod = const Duration(milliseconds: 650), this.showWhenSettled = true, this.style});
  const TextAnimateCursor.solid({this.character = '|', this.showWhenSettled = true, this.style});
  final bool enabled;
  final bool blink;
  final String character;
  final Duration blinkPeriod;
  final TextStyle? style;
  final bool showWhenSettled;
  bool operator ==(Object other);
  int get hashCode;
}
```
