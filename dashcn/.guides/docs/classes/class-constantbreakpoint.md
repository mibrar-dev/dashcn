---
title: "Class: ConstantBreakpoint"
description: "A breakpoint that steps width into uniform multiples of [step]."
---

```dart
/// A breakpoint that steps width into uniform multiples of [step].
class ConstantBreakpoint extends StageBreakpoint {
  /// Creates a constant-step breakpoint.
  const ConstantBreakpoint(this.step, {this.minSize = 0, this.maxSize = double.infinity});
  /// Step size; widths snap to multiples of it.
  final double step;
  final double minSize;
  final double maxSize;
  double getMinWidth(double width);
  double getMaxWidth(double width);
}
```
