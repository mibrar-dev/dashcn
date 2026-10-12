---
title: "Class: ComponentTheme"
description: "Tree-scoped component theme."
---

```dart
/// Tree-scoped component theme. Lookup is tree-only: it never falls back to
/// the app leg (that leg is [ComponentThemes], read separately by
/// [resolveComponentStyle]).
class ComponentTheme<T extends ComponentThemeData> extends InheritedTheme {
  const ComponentTheme({super.key, required this.data, required super.child});
  /// Theme data for type [T] in this subtree.
  final T data;
  Widget wrap(BuildContext context, Widget child);
  /// Nearest tree ancestor data. Throws when absent.
  static T of<T extends ComponentThemeData>(BuildContext context);
  /// Nearest tree ancestor data, or null. Never reads [ComponentThemes].
  static T? maybeOf<T extends ComponentThemeData>(BuildContext context);
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget);
}
```
