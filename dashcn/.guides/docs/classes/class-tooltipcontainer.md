---
title: "Class: TooltipContainer"
description: "The themed surface a tooltip's content is painted on."
---

```dart
/// The themed surface a tooltip's content is painted on.
///
/// Dependents that build their own overlay content (`tracker`, `navigation_bar`)
/// use this instead of `Tooltip` directly.
class TooltipContainer extends StatelessWidget {
  /// Creates a tooltip surface.
  const TooltipContainer({super.key, required this.child, this.theme, this.padding, this.borderRadius, this.maxWidth});
  /// The tooltip content.
  final Widget child;
  /// Widget-leg theme override, merged on top of the other legs.
  final TooltipTheme? theme;
  /// Inner padding override; applied once, never re-scaled.
  final EdgeInsetsGeometry? padding;
  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;
  /// Maximum content width before wrapping.
  final double? maxWidth;
  Widget build(BuildContext context);
}
```
