---
title: "Class: ComponentThemes"
description: "App-override leg: user-owned `<name>_theme."
---

```dart
/// App-override leg: user-owned `<name>_theme.dart` values, one entry per
/// installed component, provided once at the app root (the generated
/// `component_themes.dart` exports `const appComponentThemes`, a
/// `List<ComponentThemeData>` passed here by the app widget).
/// A different widget type from [ComponentTheme], so the app leg and the
/// tree-scoped leg stay distinct; read together only by [resolveComponentStyle].
class ComponentThemes extends InheritedWidget {
  const ComponentThemes({super.key, required this.themes, required super.child});
  /// App-override entries, one per component type.
  final List<ComponentThemeData> themes;
  /// Entry of type [T] from the nearest [ComponentThemes], or null.
  static T? maybeOf<T extends ComponentThemeData>(BuildContext context);
  bool updateShouldNotify(covariant ComponentThemes oldWidget);
}
```
