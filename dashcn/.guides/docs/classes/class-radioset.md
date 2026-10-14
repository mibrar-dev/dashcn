---
title: "Class: RadioSet"
description: "A single-select group of radio items."
---

```dart
/// A single-select group of radio items.
///
/// Two modes: controlled (`value` + `onChanged`, null `onChanged` disables) or
/// uncontrolled ([RadioSetController]). The group owns the layout —
/// [items] stacks along [direction] with [RadioGroupTheme.itemsGap] between
/// them (upstream `grid gap-3`) — plus the selection, the arrow-key traversal and
/// the form value.
class RadioSet<T> extends StatefulWidget {
  /// Creates a radio group.
  const RadioSet({super.key, required this.items, this.value, this.controller, this.onChanged, this.enabled, this.direction = Axis.vertical, this.theme});
  /// The items, stacked by the group along [direction].
  final List<Widget> items;
  /// The selected value in controlled mode.
  final T? value;
  /// Controller mode: the controller owns the selection.
  final RadioSetController<T>? controller;
  /// Called with the newly selected value in controlled mode.
  final ValueChanged<T>? onChanged;
  /// Overrides the enabled state; null means "interactive when driven".
  final bool? enabled;
  /// Arrow-key reading order: vertical walks top to bottom, horizontal left to
  /// right.
  final Axis direction;
  /// Widget-leg theme override for the group.
  final RadioGroupTheme? theme;
  State<RadioSet<T>> createState();
}
```
