---
title: "Class: SingleCalendarValue"
description: "One selected date; the time of day is ignored."
---

```dart
/// One selected date; the time of day is ignored.
class SingleCalendarValue extends CalendarValue {
  /// Selects [date].
  const SingleCalendarValue(this.date);
  final DateTime date;
  CalendarValueLookup lookupDate(DateTime other);
  CalendarValueLookup lookupMonth(int year, int month);
  CalendarValueLookup lookupYear(int year);
  bool operator ==(Object other);
  int get hashCode;
}
```
