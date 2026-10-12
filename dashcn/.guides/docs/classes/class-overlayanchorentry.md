---
title: "Class: OverlayAnchorEntry"
description: "A registry entry for a registered [OverlayAnchor]."
---

```dart
/// A registry entry for a registered [OverlayAnchor].
class OverlayAnchorEntry {
  /// Creates an entry.
  const OverlayAnchorEntry({required this.renderBox});
  /// The [RenderBox] of the registered anchor. The old entry also carried the
  /// element, but every read went through `findRenderObject()`, which stays
  /// non-null after detach; `attached` on this box is the honest liveness check.
  final RenderBox renderBox;
}
```
