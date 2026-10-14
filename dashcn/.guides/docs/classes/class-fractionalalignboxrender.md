---
title: "Class: FractionalAlignBoxRender"
description: "The render box behind [FractionalAlignBox]: lays the child out under  `maxWidth * factor`, sizes itself from the constraints and positions the  child with the resolved alignment."
---

```dart
/// The render box behind [FractionalAlignBox]: lays the child out under
/// `maxWidth * factor`, sizes itself from the constraints and positions the
/// child with the resolved alignment.
class FractionalAlignBoxRender extends RenderShiftedBox {
  /// Creates the render box.
  FractionalAlignBoxRender({required this._factor, required this._alignment, RenderBox? child});
  /// Share of the incoming width the child may use.
  double get factor;
  set factor(double value);
  /// Position of the child inside this box.
  Alignment get alignment;
  set alignment(Alignment value);
  void performLayout();
  Size computeDryLayout(covariant BoxConstraints constraints);
}
```
