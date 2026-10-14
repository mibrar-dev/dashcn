---
title: "Class: MultipleAnswerController"
description: "Holds the values of an uncontrolled [MultipleAnswer]."
---

```dart
/// Holds the values of an uncontrolled [MultipleAnswer].
class MultipleAnswerController<T> extends ValueNotifier<Iterable<T>?> with ComponentController<Iterable<T>?> {
  /// Creates a controller holding the selected items.
  MultipleAnswerController([super.value]);
}
```
