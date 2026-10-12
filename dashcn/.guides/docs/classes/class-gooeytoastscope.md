---
title: "Class: GooeyToastScope"
description: "Publishes a [GooeyToastController] (and its resolved theme) to the subtree."
---

```dart
/// Publishes a [GooeyToastController] (and its resolved theme) to the subtree.
class GooeyToastScope extends InheritedWidget {
  /// Creates a scope.
  const GooeyToastScope({super.key, required this.controller, required this.theme, required super.child});
  /// Controller of the enclosing layer.
  final GooeyToastController controller;
  /// Theme resolved by the enclosing layer.
  final GooeyToastTheme theme;
  /// Nearest scope above [context], or null.
  static GooeyToastScope? maybeOf(BuildContext context);
  bool updateShouldNotify(GooeyToastScope oldWidget);
}
```
