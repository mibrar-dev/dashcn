---
title: "Class: StepperIndicatorStyle"
description: "Visual contract of one step indicator."
---

```dart
/// Visual contract of one step indicator.
class StepperIndicatorStyle implements Mergeable<StepperIndicatorStyle> {
  /// Creates an indicator style.
  const StepperIndicatorStyle({this.background, this.foreground, this.borderColor, this.borderWidth});
  /// Fill of the indicator.
  final ThemedColor? background;
  /// Colour of the number, the check mark or the failure cross.
  final ThemedColor? foreground;
  /// Colour of the indicator ring.
  final ThemedColor? borderColor;
  /// Ring width. Default: 2 (multiplied by `scaling`).
  final double? borderWidth;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StepperIndicatorStyle merge(StepperIndicatorStyle? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
