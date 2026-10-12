---
title: "Mixin: Choice"
description: "The selection protocol every choice item reads from its scope."
---

```dart
/// The selection protocol every choice item reads from its scope.
///
/// Items call [Choice.choose] / [Choice.getValue] with the nearest scope; any
/// widget can be a choice item as long as it does that.
mixin Choice<T> {
  /// Selects (or toggles) [item] in the nearest scope.
  static void choose<T>(BuildContext context, T item);
  /// The selected items of the nearest scope, or null when there is none.
  static Iterable<T>? getValue<T>(BuildContext context);
  /// Applies one user selection to this scope.
  void selectItem(T item);
  /// The current selection: one item for [MultipleChoice], all items for
  /// [MultipleAnswer].
  Iterable<T>? get value;
}
```
