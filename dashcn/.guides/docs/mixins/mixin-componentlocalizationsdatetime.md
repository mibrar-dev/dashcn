---
title: "Mixin: ComponentLocalizationsDateTime"
description: "Calendar, date, time and duration text for [ComponentLocalizations]."
---

```dart
/// Calendar, date, time and duration text for [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsDateTime {
  String get datePickerSelectYear;
  String get placeholderDatePicker;
  String get timeAM;
  String get timePM;
  String get timeHour;
  String get timeMinute;
  String get timeSecond;
  String get placeholderTimePicker;
  String get placeholderDurationPicker;
  String get durationDay;
  String get durationHour;
  String get durationMinute;
  String get durationSecond;
  String get timeDaysAbbreviation;
  String get timeHoursAbbreviation;
  String get timeMinutesAbbreviation;
  String get timeSecondsAbbreviation;
  String get monthJanuary;
  String get monthFebruary;
  String get monthMarch;
  String get monthApril;
  String get monthMay;
  String get monthJune;
  String get monthJuly;
  String get monthAugust;
  String get monthSeptember;
  String get monthOctober;
  String get monthNovember;
  String get monthDecember;
  String get abbreviatedMonday;
  String get abbreviatedTuesday;
  String get abbreviatedWednesday;
  String get abbreviatedThursday;
  String get abbreviatedFriday;
  String get abbreviatedSaturday;
  String get abbreviatedSunday;
  String get abbreviatedJanuary;
  String get abbreviatedFebruary;
  String get abbreviatedMarch;
  String get abbreviatedApril;
  String get abbreviatedMay;
  String get abbreviatedJune;
  String get abbreviatedJuly;
  String get abbreviatedAugust;
  String get abbreviatedSeptember;
  String get abbreviatedOctober;
  String get abbreviatedNovember;
  String get abbreviatedDecember;
  /// The abbreviated weekday name for [weekday] (1 = Monday .. 7 = Sunday).
  String getAbbreviatedWeekday(int weekday);
  /// The full month name for [month] (1 = January .. 12 = December).
  String getMonth(int month);
  /// The abbreviated month name for [month] (1 = January .. 12 = December).
  String getAbbreviatedMonth(int month);
}
```
