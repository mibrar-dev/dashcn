---
title: "Class: OverlayManagerLayer"
description: "Installs an [OverlayManager] into the tree."
---

```dart
/// Installs an [OverlayManager] into the tree.
///
/// See [AppLayer] for a wrapper that only installs this layer when the app
/// does not already have a manager.
class OverlayManagerLayer extends StatefulWidget {
  /// Handler for popover overlays.
  final OverlayHandler popoverHandler;
  /// Handler for tooltip overlays.
  final OverlayHandler tooltipHandler;
  /// Handler for menu overlays.
  final OverlayHandler menuHandler;
  /// The wrapped subtree.
  final Widget child;
  /// Creates an overlay manager layer.
  const OverlayManagerLayer({super.key, required this.popoverHandler, required this.tooltipHandler, required this.menuHandler, required this.child});
  State<OverlayManagerLayer> createState();
}
```
