---
title: "Class: MediaQueryVisibility"
description: "Width-driven child switching."
---

```dart
/// Width-driven child switching.
///
/// ```dart
/// MediaQueryVisibility(
///   minWidth: 768,
///   alternateChild: const MobileNav(),
///   child: const DesktopNav(),
/// )
/// ```
///
/// Both bounds are optional: with neither the child always shows. An
/// out-of-range viewport renders [alternateChild] when it is given, and a
/// zero-size box otherwise, so the widget never reserves layout space for
/// content it is not showing.
class MediaQueryVisibility extends StatelessWidget {
  /// Creates a width-responsive child switch.
  const MediaQueryVisibility({super.key, this.minWidth, this.maxWidth, required this.child, this.alternateChild, this.theme});
  /// Narrowest viewport width (inclusive) that shows [child].
  final double? minWidth;
  /// Widest viewport width (inclusive) that shows [child].
  final double? maxWidth;
  /// Shown while the viewport width is inside the range.
  final Widget child;
  /// Shown while the viewport width is outside the range; null collapses the
  /// box instead.
  final Widget? alternateChild;
  /// Widget-leg theme override, merged on top of the other legs.
  final MediaQueryVisibilityTheme? theme;
  Widget build(BuildContext context);
}
```
