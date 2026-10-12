---
title: "Class: StepperController"
description: "Navigation state for a controller-driven [Stepper]."
---

```dart
/// Navigation state for a controller-driven [Stepper].
///
/// The [Stepper] keeps [stepCount] in sync so [next] and [previous] stop at
/// the ends instead of walking past them.
class StepperController extends ChangeNotifier {
  /// Creates a controller starting at [currentStep].
  StepperController([int currentStep = 0]);
  /// Index of the active step (0-based).
  int get currentStep;
  /// Flagged steps by index; unmodifiable.
  Map<int, StepperStepState> get stepStates;
  /// Number of steps; written by the [Stepper] on every build.
  int stepCount;
  /// Moves to the next step; false at the last one.
  bool next();
  /// Moves to the previous step; false at the first one.
  bool previous();
  /// Jumps to [index], clamped to the valid range; false when unchanged.
  bool jumpTo(int index);
  /// Flags or clears a step; null clears the flag. A no-op write (the same
  /// flag on the same index) does not notify.
  void setStepState(int index, StepperStepState? state);
}
```
