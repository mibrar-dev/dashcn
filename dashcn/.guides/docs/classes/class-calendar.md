---
title: "Class: Calendar"
description: "A date, month or year grid."
---

```dart
/// A date, month or year grid. Controlled: it paints [value] and reports every
/// change through [onChanged], like the upstream web kit's `React.Calendar`.
///
/// Keyboard: one tab stop, not 42 — the roving-tabindex model. Arrows move a day
/// (wrapping at the row edge) or a week, `Home`/`End` the ends of the week,
/// `PageUp`/`PageDown` a month, `Shift` plus those a year, `Enter`/`Space`
/// select; a disabled cell is skipped.
class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.view, this.viewType = CalendarViewType.date, this.selectionMode = CalendarSelectionMode.none, this.value, this.now, this.onChanged, this.onViewChanged, this.stateBuilder, this.firstDayOfWeek = DateTime.monday, this.autofocus = false, this.theme});
  /// The month shown by [CalendarViewType.date], the year by the other two, and
  /// how a tap changes the selection.
  final CalendarView view;
  final CalendarViewType viewType;
  final CalendarSelectionMode selectionMode;
  /// The current selection; null when nothing is selected.
  final CalendarValue? value;
  /// The date highlighted as "today"; null draws none.
  final DateTime? now;
  /// The next selection (null when a tap cleared it), and the new month when a
  /// keyboard move takes the focus past the shown one.
  final ValueChanged<CalendarValue?>? onChanged;
  final ValueChanged<CalendarView>? onViewChanged;
  /// Decides whether a cell is interactive; null enables everything.
  final DateStateBuilder? stateBuilder;
  final int firstDayOfWeek;
  final bool autofocus;
  /// Widget-leg theme override; the value a tap or an `Enter` on [date] produces
  /// comes from [calendarSelect] (see [select]).
  final CalendarTheme? theme;
  CalendarValue? select(DateTime date);
  State<Calendar> createState();
}
```
