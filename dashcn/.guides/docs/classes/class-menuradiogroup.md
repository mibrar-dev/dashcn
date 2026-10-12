---
title: "Class: MenuRadioGroup"
description: "Shared selection of a [MenuRadioItem] set, provided to the subtree."
---

```dart
/// Shared selection of a [MenuRadioItem] set, provided to the subtree.
class MenuRadioGroup<T> extends StatelessWidget {
  const MenuRadioGroup({super.key, required this.value, required this.onChanged, required this.child});
  final T? value;
  final MenuChangedCallback<T>? onChanged;
  final Widget child;
  Widget build(BuildContext context);
}
```
