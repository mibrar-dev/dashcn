---
title: "Class: CalendarGridMoveIntent"
description: "Requests a [CalendarGridMove] on the focused day."
---

```dart
/// Requests a [CalendarGridMove] on the focused day.
class CalendarGridMoveIntent extends Intent {
  /// Creates the intent for [move].
  const CalendarGridMoveIntent(this.move);
  /// The move the key asked for.
  final CalendarGridMove move;
}
```
