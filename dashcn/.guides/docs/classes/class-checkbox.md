---
title: "Class: Checkbox"
description: "A tri-state checkbox."
---

```dart
/// A tri-state checkbox.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` disables).
class Checkbox extends StatefulWidget {
  /// Creates a checkbox.
  const Checkbox({super.key, this.value = CheckboxValue.unchecked, this.controller, this.onChanged, this.tristate = false, this.enabled, this.label, this.size, this.gap, this.padding, this.focusNode, this.autofocus = false, this.onHover, this.onFocusChange, this.theme});
  /// Current value in controlled mode.
  final CheckboxValue value;
  /// Controller mode: the controller owns the value.
  final CheckboxController? controller;
  /// Called with the next value in controlled mode.
  final ValueChanged<CheckboxValue>? onChanged;
  /// Whether a tap cycles through the indeterminate state as well.
  final bool tristate;
  /// Overrides the enabled state; null means "interactive when controlled or
  /// controller-driven".
  final bool? enabled;
  /// Text shown next to the box.
  final Widget? label;
  /// Side length of the box; null falls back to the size table.
  final double? size;
  /// Space between the box and [label]; null falls back to the size table.
  final double? gap;
  /// Padding around the whole control; null falls back to the size table.
  final EdgeInsetsGeometry? padding;
  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null.
  final FocusNode? focusNode;
  /// Whether the checkbox requests focus when first built.
  final bool autofocus;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Widget-leg override, merged over the component/app/defaults.
  final CheckboxStyle? theme;
  State<Checkbox> createState();
}
```
