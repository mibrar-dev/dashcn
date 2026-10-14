---
title: "Class: OverlayAnchor"
description: "A widget that acts as a generalised anchor for overlays: it registers its  [RenderBox] and [BuildContext] in the nearest [OverlayAnchorRegistry] under  [anchor], where [LinkedAnchor] looks it up again."
---

```dart
/// A widget that acts as a generalised anchor for overlays: it registers its
/// [RenderBox] and [BuildContext] in the nearest [OverlayAnchorRegistry] under
/// [anchor], where [LinkedAnchor] looks it up again.
class OverlayAnchor extends SingleChildRenderObjectWidget {
  /// Creates an anchor.
  const OverlayAnchor({super.key, required this.anchor, required Widget super.child});
  /// The key representing this anchor; unique inside its scope.
  final Object anchor;
  RenderOverlayAnchor createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, covariant RenderOverlayAnchor renderObject);
}
```
