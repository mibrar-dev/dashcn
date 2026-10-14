---
title: "Class: StagedBreakpoint"
description: "A breakpoint that snaps width to the nearest value in [breakpoints]."
---

```dart
/// A breakpoint that snaps width to the nearest value in [breakpoints].
class StagedBreakpoint extends StageBreakpoint {
  /// Creates a staged breakpoint from ascending [breakpoints].
  ///
  /// [breakpoints] must not be empty; [minSize] / [maxSize] read its ends.
  const StagedBreakpoint(this.breakpoints);
  /// Creates a staged breakpoint with the default responsive values.
  const StagedBreakpoint.defaultBreakpoints();
  /// Ascending breakpoint widths.
  final List<double> breakpoints;
  double get minSize;
  double get maxSize;
  double getMinWidth(double width);
  double getMaxWidth(double width);
}
```
