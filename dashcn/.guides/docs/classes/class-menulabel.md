---
title: "Class: MenuLabel"
description: "A non-interactive section header (upstream `font-semibold`)."
---

```dart
/// A non-interactive section header (upstream `font-semibold`).
///
/// Plain widget on purpose: headers never take focus, so they stay out of
/// the `MenuItem` traversal contract and compose into any row list.
class MenuLabel extends StatelessWidget {
  /// Creates a menu label.
  const MenuLabel({super.key, required this.child});
  /// Label content.
  final Widget child;
  Widget build(BuildContext context);
}
```
