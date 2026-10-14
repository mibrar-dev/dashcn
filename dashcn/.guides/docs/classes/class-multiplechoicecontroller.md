---
title: "Class: MultipleChoiceController"
description: "Holds the value of an uncontrolled [MultipleChoice]."
---

```dart
/// Holds the value of an uncontrolled [MultipleChoice].
class MultipleChoiceController<T> extends ValueNotifier<T?> with ComponentController<T?> {
  /// Creates a controller holding a single selected item.
  MultipleChoiceController([super.value]);
}
```
