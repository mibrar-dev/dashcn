---
title: "Class: CheckboxController"
description: "Holds the value of an uncontrolled [Checkbox]."
---

```dart
/// Holds the value of an uncontrolled [Checkbox].
class CheckboxController extends ValueNotifier<CheckboxValue> {
  /// Creates a controller, unchecked by default.
  CheckboxController([super.value = CheckboxValue.unchecked]);
  /// Moves to [CheckboxValue.checked].
  void check();
  /// Moves to [CheckboxValue.unchecked].
  void uncheck();
  /// Moves to [CheckboxValue.indeterminate].
  void setIndeterminate();
  /// Flips between checked and unchecked; indeterminate becomes checked.
  void toggle();
  /// Cycles unchecked -> checked -> indeterminate -> unchecked.
  void cycle();
}
```
