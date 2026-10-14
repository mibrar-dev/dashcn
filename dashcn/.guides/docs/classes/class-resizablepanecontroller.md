---
title: "Class: ResizablePaneController"
description: "Controller for one resizable pane."
---

```dart
/// Controller for one resizable pane.
///
/// A pane is either absolute ([size]) or flexible ([flex]); provide exactly
/// one. Replaces the old `AbsoluteResizablePaneController` /
/// `FlexibleResizablePaneController` pair (clean break).
class ResizablePaneController extends ChangeNotifier {
  /// Creates a pane controller.
  ResizablePaneController({double? size, double? flex, this._collapsed = false});
  /// Whether this pane sizes itself proportionally.
  bool get isFlexible;
  /// The current size (pixels) or flex factor.
  double get value;
  /// Whether the pane is collapsed.
  bool get collapsed;
  /// Sets an absolute pixel size.
  void setSize(double value);
  /// Sets a flex factor.
  void setFlex(double value);
  /// Collapses the pane to its minimum size.
  void collapse();
  /// Expands the pane back to its normal size.
  void expand();
  /// The pane's size for [paneSize], clamped to the constraints.
  double computeSize(double paneSize, {double? minSize, double? maxSize});
}
```
