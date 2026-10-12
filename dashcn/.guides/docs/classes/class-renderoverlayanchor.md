---
title: "Class: RenderOverlayAnchor"
description: "The render object for [OverlayAnchor]."
---

```dart
/// The render object for [OverlayAnchor]. Registers on attach, unregisters on
/// detach and re-registers when the key or the scope changes.
class RenderOverlayAnchor extends RenderProxyBox {
  /// Creates a render anchor.
  RenderOverlayAnchor({required this._anchor, required this._registry, RenderBox? child});
  /// Updates the key and the registry.
  void update({required Object anchor, required OverlayAnchorRegistry registry});
  void attach(PipelineOwner owner);
  void detach();
}
```
