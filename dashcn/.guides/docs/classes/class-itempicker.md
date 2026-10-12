---
title: "Class: ItemPicker"
description: "Field editing a value by picking one item; a tap selects and closes."
---

```dart
/// Field editing a value by picking one item; a tap selects and closes.
class ItemPicker<T> extends StatelessWidget {
  const ItemPicker({super.key, required this.items, required this.builder, this.value, this.onChanged, this.layout = ItemPickerLayout.grid, this.placeholder, this.title, this.mode = PromptMode.dialog, this.constraints, this.theme});
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final T? value;
  /// Called with the next value; null disables the field.
  final ValueChanged<T?>? onChanged;
  final ItemPickerLayout layout;
  final Widget? placeholder;
  /// Heading of the dialog prompt.
  final Widget? title;
  /// Dialog or popover presentation.
  final PromptMode mode;
  final BoxConstraints? constraints;
  /// Widget-leg theme override, merged over the other legs.
  final ItemPickerTheme? theme;
  Widget build(BuildContext context);
}
```
