---
title: "Class: AnimatedTheme"
description: "Animates [ThemeData] changes implicitly."
---

```dart
/// Animates [ThemeData] changes implicitly.
class AnimatedTheme extends ImplicitlyAnimatedWidget {
  const AnimatedTheme({super.key, required this.data, required super.duration, super.curve, required this.child});
  /// Target theme data.
  final ThemeData data;
  /// Widget below this widget in the tree.
  final Widget child;
  AnimatedWidgetBaseState<AnimatedTheme> createState();
}
```
