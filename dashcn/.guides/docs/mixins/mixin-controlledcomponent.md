---
title: "Mixin: ControlledComponent"
description: "The contract every controlled component satisfies."
---

```dart
/// The contract every controlled component satisfies.
///
/// A component is driven either by a [controller] (controlled mode: the
/// controller owns the value) or by [initialValue] plus internal state
/// (uncontrolled mode).
mixin ControlledComponent<T> on Widget {
  /// External owner of this component's value, when there is one.
  ///
  /// Takes precedence over [initialValue].
  ComponentController<T>? get controller;
  /// Starting value used only while [controller] is null.
  T? get initialValue;
  /// Called with the new value whenever it changes.
  ValueChanged<T>? get onChanged;
  /// Whether the component accepts user input.
  bool get enabled;
}
```
