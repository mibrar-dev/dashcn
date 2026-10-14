---
title: "Enum: CalendarSelectionMode"
description: "How a date cell reacts to a tap."
---

```dart
/// How a date cell reacts to a tap. [none] is a read-only display; tapping
/// the selection in [single] clears it; [range] moves or clears an endpoint;
/// [multi] toggles one date of a list.
enum CalendarSelectionMode {
  none,
  single,
  range,
  multi,
}
```
