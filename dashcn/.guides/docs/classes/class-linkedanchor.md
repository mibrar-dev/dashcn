---
title: "Class: LinkedAnchor"
description: "An [Anchor] resolved through the nearest [OverlayAnchorRegistry], by the key  an [OverlayAnchor] registered itself under."
---

```dart
/// An [Anchor] resolved through the nearest [OverlayAnchorRegistry], by the key
/// an [OverlayAnchor] registered itself under. The registry comes from the
/// `BuildContext` passed to [Anchor.resolve]; pass [registry] to pick one.
class LinkedAnchor extends Anchor {
  /// Creates a linked anchor.
  const LinkedAnchor(this.key, {this.registry});
  /// The registry key, matching an [OverlayAnchor.anchor].
  final Object key;
  /// The registry this anchor is bound to; filled in by [resolve].
  final OverlayAnchorRegistry? registry;
  Anchor resolve(BuildContext context);
  AnchorSubscription subscribe();
}
```
