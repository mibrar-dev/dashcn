---
title: "Class: OverlayBarrier"
description: "Visual configuration of the modal barrier behind an overlay."
---

```dart
/// Visual configuration of the modal barrier behind an overlay.
class OverlayBarrier {
  /// Padding around the barrier.
  final EdgeInsetsGeometry padding;
  /// Border radius of the barrier shape.
  final BorderRadiusGeometry borderRadius;
  /// Barrier color (typically semi-transparent).
  final Color? barrierColor;
  /// Creates an overlay barrier configuration.
  const OverlayBarrier({this.padding = EdgeInsets.zero, this.borderRadius = BorderRadius.zero, this.barrierColor});
}
```
