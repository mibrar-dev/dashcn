---
title: "Class: ObjectFormHandler"
description: "Controls an open object editor from inside `editorBuilder`."
---

```dart
/// Controls an open object editor from inside `editorBuilder`.
abstract class ObjectFormHandler<T> {
  /// The value the editor is working on.
  T? get value;
  /// Updates the editor's working value.
  set value(T? value);
  /// Opens another prompt with [value].
  void prompt([T? value]);
  /// Closes the editor; completes when its route/overlay is gone.
  Future<void> close();
  /// Nearest handler (`find` returns null instead of asserting).
  static ObjectFormHandler<T> of<T>(BuildContext context);
  static ObjectFormHandler<T>? find<T>(BuildContext context);
}
```
