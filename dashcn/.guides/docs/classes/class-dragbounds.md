---
title: "Class: DragBounds"
description: "The rectangle a dragged item may be translated inside."
---

```dart
/// The rectangle a dragged item may be translated inside.
///
/// The layer clamps the drag translation so the ghost never leaves the layer
/// bounds. [minOffset] and [maxOffset] are the item's top-left and bottom-right
/// corners expressed in layer coordinates, which is what makes the clamp work
/// for nested and scrolled layers.
class DragBounds {
  /// Creates bounds from explicit layer-space corners.
  const DragBounds({required this.layerSize, required this.minOffset, required this.maxOffset});
  /// Reads the item's layer-space corners from a transform to [layerSize].
  factory DragBounds.fromTransform(Matrix4 transform, Size itemSize, Size layerSize);
  /// Size of the layer the drag is clamped to.
  final Size layerSize;
  /// Top-left corner of the item in layer coordinates.
  final Offset minOffset;
  /// Bottom-right corner of the item in layer coordinates.
  final Offset maxOffset;
  /// Size of the item being dragged.
  Size get itemSize;
  /// Whether the item is wider than the layer.
  bool get overflowsHorizontally;
  /// Whether the item is taller than the layer.
  bool get overflowsVertically;
  /// Largest translation the item can take on [axis] without leaving the layer.
  ///
  /// Negative when the item is larger than the layer: there is no position that
  /// keeps it inside, so [clampTranslation] pins that axis to zero instead of
  /// inverting the drag direction.
  double maxTranslationOn(Axis axis);
  /// Applies [delta] to [current] and clamps the result to the bounds.
  ///
  /// The old `_handleDrag` clamped with `min(low, high)` / `max(low, high)`,
  /// which turned an inverted range into a drag that moved the ghost the wrong
  /// way whenever the item was larger than the layer. The range also accounts
  /// for the item's starting corner: an item below the layer origin may move
  /// up by up to its own top (`-minOffset`), not just down (P7-Q2: upward
  /// drags were pinned to zero, so list items could only reorder downward).
  Offset clampTranslation(Offset current, Offset delta);
  /// The layer-space point the drag hits, i.e. the centre of the translated
  /// item. This is what hit tests are run against.
  Offset probePosition(Offset translation);
  String toString();
}
```
