---
title: "Class: DatePickerTheme"
description: "Timing-free behaviour contract of the date picker trigger."
---

```dart
/// Timing-free behaviour contract of the date picker trigger.
class DatePickerTheme extends ComponentThemeData implements Mergeable<DatePickerTheme> {
  /// Creates a date picker theme.
  const DatePickerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.mode, this.initialView, this.initialViewType, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding});
  /// Dialog or popover presentation; null resolves dialog.
  final PromptMode? mode;
  /// Month the calendar opens on; null resolves the current month.
  final CalendarView? initialView;
  /// Grid shown first; null resolves date.
  final CalendarViewType? initialViewType;
  /// Card placement in popover mode; null resolves top-left.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge in popover mode; null resolves bottom-left.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover surface; null resolves the primitive default.
  final EdgeInsetsGeometry? popoverPadding;
  /// Returns a copy with the given fields replaced.
  DatePickerTheme copyWith({ValueGetter<PromptMode?>? mode, ValueGetter<CalendarView?>? initialView, ValueGetter<CalendarViewType?>? initialViewType, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<EdgeInsetsGeometry?>? popoverPadding});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  DatePickerTheme merge(DatePickerTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
