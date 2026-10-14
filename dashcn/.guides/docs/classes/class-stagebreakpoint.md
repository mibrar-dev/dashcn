---
title: "Class: StageBreakpoint"
description: "A width strategy for `StageContainer`: it snaps a measured width to the  minimum and maximum content widths the layout should use."
---

```dart
/// A width strategy for `StageContainer`: it snaps a measured width to the
/// minimum and maximum content widths the layout should use.
class StageBreakpoint {
  /// Const constructor for subclasses.
  const StageBreakpoint();
  /// Default responsive breakpoints: 576, 768, 992, 1200, 1400.
  static const StageBreakpoint defaultBreakpoints = StagedBreakpoint.defaultBreakpoints();
  /// The minimum width this strategy allows.
  double get minSize;
  /// The maximum width this strategy allows.
  double get maxSize;
  /// Snapped-down content width for a container of [width].
  double getMinWidth(double width);
  /// Snapped-up content width for a container of [width].
  double getMaxWidth(double width);
}
```
