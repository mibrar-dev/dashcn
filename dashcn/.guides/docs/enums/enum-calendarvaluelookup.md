---
title: "Enum: CalendarValueLookup"
description: "Where a queried date, month or year sits relative to a [CalendarValue]."
---

```dart
/// Where a queried date, month or year sits relative to a [CalendarValue].
enum CalendarValueLookup {
  /// Not part of the value.
  none,
  /// Directly selected.
  selected,
  /// First day of a range.
  start,
  /// Last day of a range.
  end,
  /// Inside a range, but not an endpoint.
  inRange,
}
```
