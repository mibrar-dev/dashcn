---
title: "Class: ItemPickerDialog"
description: "Body of an item picker: optional title plus the themed items box."
---

```dart
/// Body of an item picker: optional title plus the themed items box.
class ItemPickerDialog<T> extends StatelessWidget {
  const ItemPickerDialog({super.key, required this.items, required this.builder, this.value, this.onChanged, this.layout = ItemPickerLayout.grid, this.title, this.constraints, this.theme});
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final ItemPickerLayout layout;
  final Widget? title;
  final BoxConstraints? constraints;
  /// Widget-leg theme override, merged over the other legs.
  final ItemPickerTheme? theme;
  Widget build(BuildContext context);
}
```
