---
title: "Class: ItemPickerOption"
description: "Selectable option: ghost button in a dialog, stacked visual elsewhere."
---

```dart
/// Selectable option: ghost button in a dialog, stacked visual elsewhere.
class ItemPickerOption<T> extends StatelessWidget {
  const ItemPickerOption({super.key, required this.value, required this.child, this.label, this.style, this.selectedStyle});
  /// Value selecting this option reports.
  final T value;
  /// Item visual.
  final Widget child;
  /// Optional caption.
  final Widget? label;
  /// Button style when unselected (default: ghost row).
  final ButtonVariantStyle? style;
  /// Button style when selected (default: primary row).
  final ButtonVariantStyle? selectedStyle;
  Widget build(BuildContext context);
}
```
