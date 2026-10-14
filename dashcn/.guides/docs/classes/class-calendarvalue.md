---
title: "Class: CalendarValue"
description: "A selection in a calendar: one date, a start/end pair, or a list."
---

```dart
/// A selection in a calendar: one date, a start/end pair, or a list. The three
/// `lookup` methods answer the same question at three granularities, so all
/// three grids share one paint path. Sealed, so nobody invents a fourth shape.
class CalendarValue {
  const CalendarValue();
  /// One selected date.
  factory CalendarValue.single(DateTime date);
  /// A range; [end] is normalised to be on or after [start].
  factory CalendarValue.range(DateTime start, DateTime end);
  /// Any number of selected dates.
  factory CalendarValue.multi(List<DateTime> dates);
  /// How [date], the month ([year], [month]) or [year] relates to this value.
  CalendarValueLookup lookupDate(DateTime date);
  CalendarValueLookup lookupMonth(int year, int month);
  CalendarValueLookup lookupYear(int year);
}
```
