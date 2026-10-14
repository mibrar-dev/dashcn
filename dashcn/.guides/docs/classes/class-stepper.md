---
title: "Class: Stepper"
description: "A sequence of steps with progress indication."
---

```dart
/// A sequence of steps with progress indication.
///
/// Two modes, like `Toggle`: uncontrolled with a [StepperController], or
/// controlled with [currentStep] + [onStepChanged]; activating a step jumps to
/// it.
///
/// ```dart
/// Stepper(currentStep: 1, steps: <StepperStep>[
///   StepperStep(title: Text('Account'), content: Text('form')),
/// ]);
/// ```
class Stepper extends StatelessWidget {
  /// Creates a stepper.
  const Stepper({super.key, required this.steps, this.controller, this.currentStep, this.onStepChanged, this.direction, this.size, this.theme});
  /// The steps, in order.
  final List<StepperStep> steps;
  /// Uncontrolled mode: the controller owns the active step.
  final StepperController? controller;
  /// Controlled mode: index of the active step.
  final int? currentStep;
  /// Controlled mode: called with the next index when a step is activated.
  final ValueChanged<int>? onStepChanged;
  /// Layout axis; falls back to the theme.
  final Axis? direction;
  /// Indicator size; falls back to the theme.
  final StepperSize? size;
  /// Widget-leg theme override, merged on top of the other legs.
  final StepperTheme? theme;
  Widget build(BuildContext context);
}
```
