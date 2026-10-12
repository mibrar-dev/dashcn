---
title: "Class: MenuPopupSurface"
description: "The popup surface rows are presented on, from resolved values."
---

```dart
/// The popup surface rows are presented on, from resolved values.
///
/// The surface hugs its content: it measures the widest row and sizes
/// between [minWidth] and [maxWidth] (at least the incoming minimum, so an
/// anchor-minimum constraint is honoured). The measurement is guarded: an
/// intrinsic-incapable descendant (a `LayoutBuilder`, e.g. the registry
/// `Slider`) throws during the query, and the surface falls back to the
/// minimum instead of failing the frame — arbitrary content (including
/// `LayoutBuilder` descendants) stays safe, which a bare `IntrinsicWidth`
/// cannot promise.
/// Height is capped at [maxHeight] with its own scroll area, so long lists
/// stay on-screen.
class MenuPopupSurface extends StatelessWidget {
  /// Creates a menu popup surface.
  const MenuPopupSurface({super.key, required this.children, this.fill, this.foreground, this.borderColor, this.borderWidth = 1, this.borderRadius, this.padding, this.minWidth = 128, this.width, this.maxWidth = double.infinity, this.maxHeight = 360, this.shadows});
  /// The rows.
  final List<Widget> children;
  /// Resolved surface fill; null resolves the popover token.
  final Color? fill;
  /// Resolved content colour; null resolves popoverForeground.
  final Color? foreground;
  /// Resolved border colour; null resolves the border token.
  final Color? borderColor;
  /// Border width.
  final double borderWidth;
  /// Resolved corner radius; null resolves `borderRadiusMd`.
  final BorderRadius? borderRadius;
  /// Resolved inner padding; null resolves all 4.
  final EdgeInsetsGeometry? padding;
  /// Minimum popup width (8rem).
  final double minWidth;
  /// Exact popup width; null hugs the content between [minWidth] and
  /// [maxWidth].
  final double? width;
  /// Maximum popup width; the rows stretch to it. Defaults to unbounded so
  /// the viewport (through the popover margin) is the only cap.
  final double maxWidth;
  /// Maximum popup height; taller content scrolls inside the surface.
  final double maxHeight;
  /// Resolved popup shadow; null draws none. Callers pass the ambient
  /// `shadowMd` unless the theme overrides it.
  final List<BoxShadow>? shadows;
  Widget build(BuildContext context);
}
```
