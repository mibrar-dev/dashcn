---
title: "Class: SwitchController"
description: "Holds the value of an uncontrolled [Switch]."
---

```dart
/// Holds the value of an uncontrolled [Switch].
class SwitchController extends ValueNotifier<bool> {
  /// Creates a controller, off by default.
  SwitchController([super.value = false]);
  /// Flips the value.
  void toggle();
}
```
