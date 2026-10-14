---
title: "Class: RangeCalendarValue"
description: "A start/end pair; the constructor orders the two dates."
---

```dart
/// A start/end pair; the constructor orders the two dates.
class RangeCalendarValue extends CalendarValue {
  /// Selects the span between [start] and [end], in either order.
  RangeCalendarValue(DateTime start, DateTime end);
  /// First day of the span; never after [end].
  final DateTime start;
  /// Last day of the span; never before [start].
  final DateTime end;
  CalendarValueLookup lookupDate(DateTime date);
  CalendarValueLookup lookupMonth(int year, int month);
  CalendarValueLookup lookupYear(int year);
  bool operator ==(Object other);
  int get hashCode;
}
```
