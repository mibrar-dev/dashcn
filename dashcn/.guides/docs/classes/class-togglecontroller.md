---
title: "Class: ToggleController"
description: "Holds the on/off value of an uncontrolled [Toggle]."
---

```dart
/// Holds the on/off value of an uncontrolled [Toggle].
class ToggleController extends ValueNotifier<bool> {
  /// Creates a controller, off by default.
  ToggleController([super.value = false]);
  /// Flips the value.
  void toggle();
}
```
