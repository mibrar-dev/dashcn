---
title: "Enum: InputFeatureVisibility"
description: "Leaf visibility conditions, composable with `&`, `|` and `~`."
---

```dart
/// Leaf visibility conditions, composable with `&`, `|` and `~`.
enum InputFeatureVisibility {
  /// Always visible.
  always,
  /// Never visible.
  never,
  /// Visible while the field has focus.
  focused,
  /// Visible while the pointer hovers the field.
  hovered,
  /// Visible while the field text is empty.
  textEmpty,
  /// Visible while the field text is not empty.
  textNotEmpty,
  /// Visible while the field has a non-collapsed selection.
  hasSelection,
}
```
