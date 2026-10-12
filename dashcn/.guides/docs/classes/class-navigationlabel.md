---
title: "Class: NavigationLabel"
description: "A non-interactive section label."
---

```dart
/// A non-interactive section label.
class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  /// Creates a navigation label.
  const NavigationLabel({super.key, required this.child, this.padding, this.overflow = NavigationOverflow.clip});
  /// Label content.
  final Widget child;
  /// Label padding.
  final EdgeInsetsGeometry? padding;
  /// Label overflow behaviour.
  final NavigationOverflow overflow;
  bool get selectable;
  Widget build(BuildContext context);
}
```
