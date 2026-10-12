---
title: "Class: StateValue"
description: "Const per-state value."
---

```dart
/// Const per-state value. Implements [WidgetStateProperty] so it plugs into
/// Flutter state APIs, but carries only data (nullable per state) — no
/// closures — so every layer including user files stays const-constructible.
class StateValue<T> implements WidgetStateProperty<T?>, Mergeable<StateValue<T>> {
  const StateValue({this.rest, this.hovered, this.pressed, this.focused, this.selected, this.disabled});
  final T? rest;
  final T? hovered;
  final T? pressed;
  final T? focused;
  final T? selected;
  final T? disabled;
  /// Precedence: disabled > pressed > hovered > focused > selected > rest.
  /// Each state falls back to [rest] (never to another state).
  T? resolve(Set<WidgetState> states);
  /// First-non-null-wins per state field: keeps `this` value unless null,
  /// then takes [fallback]. Call on the higher-priority leg so overrides win.
  StateValue<T> merge(StateValue<T>? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```
