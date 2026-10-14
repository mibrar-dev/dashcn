---
title: "Class: NavigationSlot"
description: "A custom header/footer item: leading, title/subtitle and trailing, with an  optional press action (the old `NavigationSlot`)."
---

```dart
/// A custom header/footer item: leading, title/subtitle and trailing, with an
/// optional press action (the old `NavigationSlot`).
class NavigationSlot extends StatelessWidget implements NavigationBarItem {
  /// Creates a navigation slot.
  const NavigationSlot({super.key, required this.leading, required this.title, this.subtitle, this.trailing, this.trailingGap, this.onPressed, this.overflow = NavigationOverflow.ellipsis});
  /// Leading widget (usually an avatar or icon).
  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  /// Gap between the title block and [trailing].
  final double? trailingGap;
  /// Press callback; null renders an inert slot.
  final VoidCallback? onPressed;
  final NavigationOverflow overflow;
  bool get selectable;
  Widget build(BuildContext context);
}
```
