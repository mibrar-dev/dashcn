---
title: "Class: DateTimeRange"
description: "An immutable start/end date span picked by [DateRangePicker]."
---

```dart
/// An immutable start/end date span picked by [DateRangePicker].
class DateTimeRange {
  /// Creates a range; const so themes and tests stay values-only.
  const DateTimeRange(this.start, this.end);
  /// First day of the span.
  final DateTime start;
  /// Last day of the span; never before [start].
  final DateTime end;
  bool operator ==(Object other);
  int get hashCode;
}
```
