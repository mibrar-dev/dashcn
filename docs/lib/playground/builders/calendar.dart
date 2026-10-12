// Playground builder for the `calendar` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/calendar/calendar.dart';
import 'package:docs/ui/dashcn/primitives/date_math.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Calendar] from playground values.
///
/// The viewed month is builder-owned demo content.
Widget buildCalendarPlayground(BuildContext context, PlaygroundValues values) {
  return Calendar(
    view: const CalendarView(2026, 10),
    viewType:
        _byNameOrNull(CalendarViewType.values, values.getEnum('viewType')) ??
        CalendarViewType.date,
    selectionMode:
        _byNameOrNull(
          CalendarSelectionMode.values,
          values.getEnum('selectionMode'),
        ) ??
        CalendarSelectionMode.none,
    firstDayOfWeek: values.getInt('firstDayOfWeek') ?? DateTime.monday,
    autofocus: values.getBoolOr('autofocus', false),
  );
}

T? _byNameOrNull<T extends Enum>(List<T> values, String? name) {
  if (name == null) {
    return null;
  }
  for (final T value in values) {
    if (value.name == name) {
      return value;
    }
  }
  return null;
}
