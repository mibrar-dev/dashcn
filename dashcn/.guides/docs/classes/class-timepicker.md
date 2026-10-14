---
title: "Class: TimePicker"
description: "A clock-time field opening a [TimePickerDialog] sheet."
---

```dart
/// A clock-time field opening a [TimePickerDialog] sheet.
///
/// The trigger hugs its content (at least 140 upstream px): the clock icon
/// leads, the label is left-aligned, the placeholder is muted. Pass [expand]
/// for a full-width field.
class TimePicker extends StatelessWidget {
  const TimePicker({super.key, required this.value, this.onChanged, this.mode, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.use24HourFormat, this.showSeconds = false, this.dialogTitle, this.enabled, this.expand = false, this.theme});
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?>? onChanged;
  final PromptMode? mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final bool? use24HourFormat;
  final bool showSeconds;
  final Widget? dialogTitle;
  final bool? enabled;
  /// Whether the trigger stretches to the available width.
  final bool expand;
  final TimePickerTheme? theme;
  Widget build(BuildContext context);
}
```
