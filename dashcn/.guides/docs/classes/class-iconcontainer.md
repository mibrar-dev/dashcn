---
title: "Class: IconContainer"
description: "A padded, filled square around an icon."
---

```dart
/// A padded, filled square around an icon.
///
/// ```dart
/// const IconContainer(icon: Icon(LucideIcons.star));
/// ```
class IconContainer extends StatelessWidget {
  /// Creates an icon container.
  const IconContainer({super.key, required this.icon, this.backgroundColor, this.iconColor, this.padding, this.borderRadius, this.theme});
  /// The icon to display.
  final Widget icon;
  /// Container fill override.
  final Color? backgroundColor;
  /// Icon colour override.
  final Color? iconColor;
  /// Inner padding override.
  final EdgeInsetsGeometry? padding;
  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;
  /// Widget-leg theme override, merged on top of the other legs.
  final IconContainerTheme? theme;
  Widget build(BuildContext context);
}
```
