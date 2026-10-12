---
title: "Class: AnchorSubscription"
description: "A live handle on an [Anchor]'s position and visibility."
---

```dart
/// A live handle on an [Anchor]'s position and visibility. Listeners are
/// notified whenever the anchor may have moved, resized or changed visibility.
abstract class AnchorSubscription implements Listenable {
  /// Releases the subscription; it never notifies again, so implementations
  /// must stop any ticker they own here.
  void dispose();
  /// Whether the anchor currently resolves to a live, mounted render object.
  bool get isVisible;
  /// The anchor's current box size, or null when it cannot be resolved.
  Size? get anchorSize;
  /// The transform mapping the anchor's local coordinates into [source]'s. The
  /// two render objects are usually unrelated in the tree (the anchor lives in
  /// the normal tree, [source] in an overlay entry), so
  /// `RenderObject.getTransformTo` cannot be used directly between them.
  Matrix4 computeTransform(RenderObject source);
  /// Whether this subscription tracks the anchor through the compositing
  /// pipeline (zero lag, re-evaluated on scroll). Defaults to false;
  /// [_LinkedAnchorSubscription] enables it.
  bool get supportsCompositeTracking;
  /// The anchor's currently registered [RenderBox], or null. Only meaningful
  /// when [supportsCompositeTracking] is true.
  RenderBox? get currentAnchorBox;
}
```
