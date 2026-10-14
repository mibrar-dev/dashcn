---
title: "Class: RadioSetController"
description: "Holds the value of an uncontrolled [RadioSet]."
---

```dart
/// Holds the value of an uncontrolled [RadioSet].
class RadioSetController<T> extends ValueNotifier<T?> {
  /// Creates a controller, with no selection by default.
  RadioSetController([super.value]);
  /// Selects [next].
  void select(T? next);
}
```
