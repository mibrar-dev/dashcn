---
title: "Extension: WidgetStateExtension"
description: "Boolean state getters for a `Set<WidgetState>`."
---

```dart
/// Boolean state getters for a `Set<WidgetState>`.
extension WidgetStateExtension on Set<WidgetState> {
  /// Whether the widget is disabled.
  bool get disabled;
  /// Whether the widget is in an error state.
  bool get error;
  /// Whether the widget is selected.
  bool get selected;
  /// Whether the widget is pressed.
  bool get pressed;
  /// Whether the widget is hovered.
  bool get hovered;
  /// Whether the widget is focused.
  bool get focused;
}
```
