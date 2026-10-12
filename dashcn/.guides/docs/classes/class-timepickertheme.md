---
title: "Class: TimePickerTheme"
description: "Behaviour contract of the time picker trigger."
---

```dart
/// Behaviour contract of the time picker trigger.
class TimePickerTheme extends ComponentThemeData implements Mergeable<TimePickerTheme> {
  /// Creates a time picker theme.
  const TimePickerTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.mode, this.use24HourFormat, this.showSeconds, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle});
  /// Dialog or popover presentation; null resolves dialog.
  final PromptMode? mode;
  /// 12/24-hour clock; null resolves the ambient convention.
  final bool? use24HourFormat;
  /// Whether the seconds field shows; null resolves false.
  final bool? showSeconds;
  /// Card placement in popover mode; null resolves top-left.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge in popover mode; null resolves bottom-left.
  final AlignmentGeometry? popoverAnchorAlignment;
  /// Padding inside the popover surface; null resolves the primitive default.
  final EdgeInsetsGeometry? popoverPadding;
  /// Title of the dialog prompt; null shows no title.
  final Widget? dialogTitle;
  /// Returns a copy with the given fields replaced.
  TimePickerTheme copyWith({ValueGetter<PromptMode?>? mode, ValueGetter<bool?>? use24HourFormat, ValueGetter<bool?>? showSeconds, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment, ValueGetter<EdgeInsetsGeometry?>? popoverPadding, ValueGetter<Widget?>? dialogTitle});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  TimePickerTheme merge(TimePickerTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
