---
title: "Class: Skeleton"
description: "A shimmering placeholder shown while [content] is still loading."
---

```dart
/// A shimmering placeholder shown while [content] is still loading.
///
/// The widget keeps the child's layout box, so swapping it in and out never
/// moves the surrounding page:
///
/// ```dart
/// Skeleton(
///   enabled: loading,
///   child: Text('Summary'),
/// );
/// ```
class Skeleton extends StatelessWidget {
  /// Creates a skeleton placeholder.
  const Skeleton({super.key, required this.child, this.enabled = true, this.borderRadius, this.theme});
  /// The real content, laid out but painted only while [enabled] is false.
  final Widget child;
  /// Whether the placeholder is shown. A disabled skeleton paints [child].
  final bool enabled;
  /// Corner radius override; null uses `SkeletonTheme.borderRadius` and then
  /// the theme's `borderRadiusMd`.
  final BorderRadiusGeometry? borderRadius;
  /// Widget-leg theme override, merged on top of the other legs.
  final SkeletonTheme? theme;
  Widget build(BuildContext context);
}
```
