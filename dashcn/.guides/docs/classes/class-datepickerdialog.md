---
title: "Class: DatePickerDialog"
description: "The calendar sheet behind both pickers (deferred here from the B07 tree):  a month/year stepper header over one [Calendar] grid."
---

```dart
/// The calendar sheet behind both pickers (deferred here from the B07 tree):
/// a month/year stepper header over one [Calendar] grid.
///
/// Tapping a month drills into its days; tapping a year drills into its
/// months. The header title cycles date -> month -> year.
class DatePickerDialog extends StatefulWidget {
  /// Creates a date picker dialog.
  const DatePickerDialog({super.key, this.initialView, this.initialViewType = CalendarViewType.date, this.selectionMode = CalendarSelectionMode.single, this.initialValue, this.onChanged, this.stateBuilder});
  final CalendarView? initialView;
  final CalendarViewType initialViewType;
  final CalendarSelectionMode selectionMode;
  final CalendarValue? initialValue;
  final ValueChanged<CalendarValue?>? onChanged;
  final DateStateBuilder? stateBuilder;
  State<DatePickerDialog> createState();
}
```
