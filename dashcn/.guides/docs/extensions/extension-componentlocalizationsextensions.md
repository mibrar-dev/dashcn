---
title: "Extension: ComponentLocalizationsExtensions"
description: "Formatting helpers built on the [ComponentLocalizations] strings."
---

```dart
/// Formatting helpers built on the [ComponentLocalizations] strings.
///
/// The words come from the localizations instance; the separators, padding and
/// 12/24-hour convention come from the arguments.
extension ComponentLocalizationsExtensions on ComponentLocalizations {
  /// The order date fields are presented in unless the app overrides it.
  ///
  /// Month/day/year, matching the upstream and platform defaults.
  List<DatePart> get datePartsOrder;
  /// Abbreviation for the year component, e.g. `YYYY`.
  String get dateYearAbbreviation;
  /// Abbreviation for the month component, e.g. `MM`.
  String get dateMonthAbbreviation;
  /// Abbreviation for the day component, e.g. `DD`.
  String get dateDayAbbreviation;
  /// The placeholder for one date field, e.g. `MM` for [DatePart.month].
  String getDatePartAbbreviation(DatePart part);
  /// The placeholder for one clock field, e.g. `HH` for [TimePart.hour].
  String getTimePartAbbreviation(TimePart part);
  /// The placeholder for one duration field, e.g. `HH` for [DurationPart.hour].
  ///
  /// Shares [getTimePartAbbreviation]'s placeholders: a duration has no separate
  /// notation, so `DD` doubles as the day placeholder.
  String getDurationPartAbbreviation(DurationPart part);
  /// Formats [value] without a decimal point when it is a whole number.
  ///
  /// `1500.0` renders as `1500`, `1.5` as `1.5`.
  String formatNumber(double value);
  /// Renders [dateTime] as a localized date, optionally followed by the time.
  ///
  /// [showDate] drops the date part and [showTime] drops the time part;
  /// [showSeconds] adds seconds and [use24HourFormat] picks the clock
  /// convention. 12-hour output appends [timeAM] or [timePM] and ignores
  /// [showSeconds].
  String formatDateTime(DateTime dateTime, {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});
  /// Renders [time] as a clock string with zero-padded components.
  ///
  /// [use24HourFormat] picks the clock convention and [showSeconds] adds the
  /// seconds component. 12-hour output appends [timeAM] or [timePM].
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false});
  /// Renders [duration] as a compact `1d 2h 3m 4s` string.
  ///
  /// Each component is dropped when its flag is false, and zero components are
  /// dropped regardless of the flags.
  String formatDuration(Duration duration, {bool showDays = true, bool showHours = true, bool showMinutes = true, bool showSeconds = true});
}
```
