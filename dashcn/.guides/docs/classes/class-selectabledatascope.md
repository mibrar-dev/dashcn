---
title: "Class: SelectableDataScope"
description: "Provides one [SelectableData] to the items of a group."
---

```dart
/// Provides one [SelectableData] to the items of a group.
///
/// Goes through `Data`, so an item resolves it with
/// `Data.maybeOf<SelectableData<T>>(context)`.
class SelectableDataScope<T> extends StatelessWidget {
  /// Creates the scope.
  const SelectableDataScope({super.key, required this.data, required this.child});
  /// Wraps the items in the scope.
  final Widget child;
  /// The selection scope.
  final SelectableData<T> data;
  Widget build(BuildContext context);
}
```
