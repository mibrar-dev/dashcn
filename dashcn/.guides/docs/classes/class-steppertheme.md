---
title: "Class: StepperTheme"
description: "Visual contract of a stepper."
---

```dart
/// Visual contract of a stepper. Every field is nullable: an override leg sets
/// only what it changes and [merge] keeps the lower leg's remaining fields.
class StepperTheme extends ComponentThemeData implements Mergeable<StepperTheme> {
  /// Creates a stepper theme.
  const StepperTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.direction, this.size, this.active, this.completed, this.pending, this.failed, this.connectorColor, this.connectorPendingColor, this.connectorThickness, this.gap, this.titleStyle});
  /// Layout axis. Default: [Axis.horizontal].
  final Axis? direction;
  /// Indicator size. Default: [StepperSize.md].
  final StepperSize? size;
  /// The step the stepper is on.
  final StepperIndicatorStyle? active;
  /// A step before the active one.
  final StepperIndicatorStyle? completed;
  /// A step after the active one.
  final StepperIndicatorStyle? pending;
  /// The step flagged [StepperStepState.failed].
  final StepperIndicatorStyle? failed;
  /// Connector up to and including the active step. Default: `primary`.
  final ThemedColor? connectorColor;
  /// Connector after the active step. Default: `border`.
  final ThemedColor? connectorPendingColor;
  /// Connector thickness. Default: 2 (multiplied by `scaling`).
  final double? connectorThickness;
  /// Space around the indicator. Default: 8 (multiplied by `scaling`).
  final double? gap;
  /// Title style override; null takes the [size] typography.
  final TextStyle? titleStyle;
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  StepperTheme merge(StepperTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
