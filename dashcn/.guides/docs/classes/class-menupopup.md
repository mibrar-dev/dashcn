---
title: "Class: MenuPopup"
description: "The themed popup surface rows are presented on."
---

```dart
/// The themed popup surface rows are presented on. B20 re-exports this.
class MenuPopup extends StatelessWidget {
  /// Creates a menu popup.
  const MenuPopup({super.key, required this.children, this.theme, this.width, this.maxWidth, this.maxHeight});
  /// The rows.
  final List<Widget> children;
  /// Widget-leg popup theme override.
  final MenuPopupTheme? theme;
  /// Exact popup width; null hugs the content between the minimum and
  /// [maxWidth].
  final double? width;
  /// Maximum popup width; null leaves it unbounded so the viewport (through
  /// the popover margin) is the only cap.
  final double? maxWidth;
  /// Maximum popup height (default 360); null keeps the default.
  final double? maxHeight;
  Widget build(BuildContext context);
}
```
