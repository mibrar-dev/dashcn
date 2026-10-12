---
title: "Class: DatePicker"
description: "A single-date field: a trigger showing the value (or the localized  placeholder) that opens a [DatePickerDialog] in a dialog or a popover."
---

```dart
/// A single-date field: a trigger showing the value (or the localized
/// placeholder) that opens a [DatePickerDialog] in a dialog or a popover.
///
/// The trigger hugs its content (at least 240 upstream px, `w-[240px]`): the
/// calendar icon leads, the label is left-aligned, the placeholder is muted.
/// Pass [expand] for a full-width field.
class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.value, this.onChanged, this.placeholder, this.mode, this.initialView, this.initialViewType, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.stateBuilder, this.enabled, this.expand = false, this.theme});
  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
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
