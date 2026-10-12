---
title: "Class: DateInput"
description: "A typed date field: locale-ordered segments with a calendar prompt  (dialog or popover) behind the trailing button."
---

```dart
/// A typed date field: locale-ordered segments with a calendar prompt
/// (dialog or popover) behind the trailing button. Incomplete or impossible
/// dates report null; controlled with [value] + [onChanged], uncontrolled
/// with [initialValue], disabled with null [onChanged].
class DateInput extends StatelessWidget {
  /// Creates a date input.
  const DateInput({super.key, this.value, this.initialValue, this.onChanged, this.enabled = true, this.datePartsOrder, this.separator = '/', this.placeholders, this.validator, this.mode, this.initialView, this.initialViewType, this.stateBuilder, this.dialogTitle, this.theme});
  /// Controlled value; null with [onChanged] set means "no date".
  final DateTime? value;
  /// Uncontrolled seed; ignored once the field owns its state.
  final DateTime? initialValue;
  /// Called with the next date (null while incomplete/invalid).
  final ValueChanged<DateTime?>? onChanged;
  /// Whether the field accepts input; disabled dims to 50%.
  final bool enabled;
  /// Segment order; null uses the locale order.
  final List<DatePart>? datePartsOrder;
  /// Text between segments.
  final String separator;
  /// Per-part placeholder overrides; null uses locale abbreviations.
  final Map<DatePart, Widget>? placeholders;
  /// Validates the parsed date; a non-null result shows below the field.
  final String? Function(DateTime? value)? validator;
  /// Calendar prompt presentation; null is popover on desktop widths
  /// (≥ 768 logical pixels), dialog below (popover needs `OverlayManager`).
  final PromptMode? mode;
  /// Calendar sheet: starting month view.
  final CalendarView? initialView;
  /// Calendar sheet: starting grid.
  final CalendarViewType? initialViewType;
  /// Calendar sheet: per-date enablement.
  final DateStateBuilder? stateBuilder;
  /// Optional title above the calendar dialog.
  final Widget? dialogTitle;
  /// Widget-leg theme override, forwarded to [FormattedInput].
  final FormattedInputTheme? theme;
  Widget build(BuildContext context);
}
```
