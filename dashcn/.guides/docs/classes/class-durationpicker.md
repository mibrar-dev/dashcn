---
title: "Class: DurationPicker"
description: "A duration field opening a [DurationPickerDialog] sheet."
---

```dart
/// A duration field opening a [DurationPickerDialog] sheet.
class DurationPicker extends StatelessWidget {
  const DurationPicker({super.key, required this.value, this.onChanged, this.mode = PromptMode.dialog, this.placeholder, this.popoverAlignment, this.popoverAnchorAlignment, this.popoverPadding, this.dialogTitle, this.enabled, this.expand = false});
  final Duration? value;
  final ValueChanged<Duration?>? onChanged;
  final PromptMode mode;
  final Widget? placeholder;
  final AlignmentGeometry? popoverAlignment;
  final AlignmentGeometry? popoverAnchorAlignment;
  final EdgeInsetsGeometry? popoverPadding;
  final Widget? dialogTitle;
  final bool? enabled;
  /// Whether the trigger stretches to the available width.
  final bool expand;
  Widget build(BuildContext context);
}
```
