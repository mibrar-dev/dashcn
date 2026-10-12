---
title: "Class: SheetStage"
description: "Snap position for a [PinnedSheet]: a visible extent along the sheet's  axis plus, independently, a backdrop-transform value in `0."
---

```dart
/// Snap position for a [PinnedSheet]: a visible extent along the sheet's
/// axis plus, independently, a backdrop-transform value in `0..1`.
///
/// ```dart
/// SheetStage.expanded() - SheetStage.fixed(100); // 100px short of full
/// SheetStage.expanded() * 0.9; // 90% of full
/// ```
abstract class SheetStage {
  /// Const constructor for subclasses.
  const SheetStage();
  /// Fully hidden (offset 0).
  factory SheetStage.closed({double? backdropTransform});
  /// Fully shown (offset == the full axis extent).
  factory SheetStage.expanded({double? backdropTransform});
  /// Pinned at [offset] logical pixels from the edge.
  factory SheetStage.fixed(double offset, {double? backdropTransform});
  /// Pinned at [fraction] (0..1) of the axis extent.
  factory SheetStage.fraction(double fraction, {double? backdropTransform});
  /// Peeks only the drag handle; behaves like closed without a handle.
  factory SheetStage.peekDragHandle({double? backdropTransform});
  /// Live stage bound to a sheet's current position (built by controllers).
  factory SheetStage.live({required double Function() offset, required SheetStageResolution Function() resolution, required double Function() backdrop});
  /// Visible extent in logical pixels this stage resolves to.
  double resolveDragOffset(SheetStageResolution resolution);
  /// Backdrop-transform value (0..1) this stage resolves to.
  double resolveBackdropTransform(SheetStageResolution resolution);
  /// Sum of two stages.
  SheetStage operator +(SheetStage other);
  /// Difference of two stages.
  SheetStage operator -(SheetStage other);
  /// Scales offset and backdrop transform by [factor].
  SheetStage operator *(double factor);
  /// Divides offset and backdrop transform by [factor].
  SheetStage operator /(double factor);
  bool operator ==(Object other);
  int get hashCode;
}
```
