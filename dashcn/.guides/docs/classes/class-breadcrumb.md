---
title: "Class: Breadcrumb"
description: "A horizontal breadcrumb trail, scrollable when it overflows."
---

```dart
/// A horizontal breadcrumb trail, scrollable when it overflows.
///
/// The last crumb is drawn in the body foreground; every earlier crumb and the
/// separators use the muted foreground.
///
/// ```dart
/// const Breadcrumb(
///   children: <Widget>[
///     Text('Home'),
///     Text('Settings'),
///     Text('Profile'),
///   ],
/// );
/// ```
class Breadcrumb extends StatelessWidget {
  /// Creates a breadcrumb trail.
  const Breadcrumb({super.key, required this.children, this.separator, this.padding, this.theme});
  /// Chevron separator (the upstream default).
  static const Widget arrowSeparator = _BreadcrumbArrowSeparator();
  /// Slash separator.
  static const Widget slashSeparator = _BreadcrumbSlashSeparator();
  /// Crumbs, ordered from root to the current location.
  final List<Widget> children;
  /// Separator override; null resolves [BreadcrumbTheme.separator] and then
  /// [arrowSeparator].
  final Widget? separator;
  /// Padding around the strip; null resolves [BreadcrumbTheme.padding].
  final EdgeInsetsGeometry? padding;
  /// Widget-leg theme override, merged on top of the other legs.
  final BreadcrumbTheme? theme;
  Widget build(BuildContext context);
}
```
