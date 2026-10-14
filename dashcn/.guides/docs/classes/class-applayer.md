---
title: "Class: AppLayer"
description: "Wraps [child] in an [OverlayManagerLayer] unless one is already present."
---

```dart
/// Wraps [child] in an [OverlayManagerLayer] unless one is already present.
///
/// Install this (or [OverlayManagerLayer]) once at the app root so every
/// overlay shares a single stack.
class AppLayer extends StatelessWidget {
  /// The app subtree.
  final Widget child;
  /// Optional upstream theme data installed above [child].
  final ThemeData? theme;
  /// Handler for popover overlays.
  final OverlayHandler popoverHandler;
  /// Handler for tooltip overlays.
  final OverlayHandler tooltipHandler;
  /// Handler for menu overlays.
  final OverlayHandler menuHandler;
  /// Creates a layer.
  const AppLayer({super.key, required this.child, this.theme, this.popoverHandler = OverlayHandler.popover, this.tooltipHandler = OverlayHandler.popover, this.menuHandler = OverlayHandler.popover});
  Widget build(BuildContext context);
}
```
