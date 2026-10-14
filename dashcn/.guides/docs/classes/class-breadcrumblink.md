---
title: "Class: BreadcrumbLink"
description: "An interactive crumb: muted at rest, foreground with an underline on  hover/press/focus, activated by tap, Enter or Space through [Clickable]."
---

```dart
/// An interactive crumb: muted at rest, foreground with an underline on
/// hover/press/focus, activated by tap, Enter or Space through [Clickable].
///
/// Use for every crumb except the current page (plain `Text`, which
/// [Breadcrumb] already draws in the body foreground and which must stay a
/// non-link).
class BreadcrumbLink extends StatelessWidget {
  /// Creates an interactive crumb.
  const BreadcrumbLink({super.key, required this.onPressed, required this.child, this.focusNode, this.autofocus = false});
  /// Called on tap, Enter or Space; null disables the link.
  final VoidCallback? onPressed;
  /// Crumb label, usually a `Text`.
  final Widget child;
  /// Focus node of the link.
  final FocusNode? focusNode;
  /// Whether the link requests focus when first built.
  final bool autofocus;
  Widget build(BuildContext context);
}
```
