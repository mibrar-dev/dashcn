---
title: "Class: DateRangePicker"
description: "A date-span field: like [DatePicker] but the calendar selects a range in  one grid (tap twice, or tap an endpoint to clear it)."
---

```dart
/// A date-span field: like [DatePicker] but the calendar selects a range in
/// one grid (tap twice, or tap an endpoint to clear it).
class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode, this.initialView, this.initialViewType, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.stateBuilder, this.enabled, this.expand = false, this.theme});
  final DateTimeRange? value;
  final ValueChanged<DateTimeRange?>? onChanged;
  final Widget? placeholder;
  final PromptMode? mode;
  final CalendarView? initialView;
  final CalendarViewType? initialViewType;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final DateStateBuilder? stateBuilder;
  final bool? enabled;
  /// Whether the trigger stretches to the available width.
  final bool expand;
  final DatePickerTheme? theme;
  Widget build(BuildContext context);
}
```
