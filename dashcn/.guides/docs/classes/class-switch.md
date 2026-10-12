---
title: "Class: Switch"
description: "An on/off switch."
---

```dart
/// An on/off switch.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` disables).
///
/// Separate from `Toggle`: `Toggle` is a momentary button that keeps a
/// selected look, `Switch` is a dedicated setting control with a sliding
/// thumb (PLAN §4 rule 2).
class Switch extends StatefulWidget {
  /// Creates a switch.
  const Switch({super.key, this.value = false, this.controller, this.onChanged, this.enabled, this.label, this.focusNode, this.autofocus = false, this.onHover, this.onFocusChange, this.theme});
  /// Current value in controlled mode.
  final bool value;
  /// Controller mode: the controller owns the value.
  final SwitchController? controller;
  /// Called with the next value in controlled mode.
  final ValueChanged<bool>? onChanged;
  /// Overrides the enabled state; null means "interactive when controlled or
  /// controller-driven".
  final bool? enabled;
  /// Text shown next to the switch.
  final Widget? label;
  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null.
  final FocusNode? focusNode;
  /// Whether the switch requests focus when first built.
  final bool autofocus;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Widget-leg override, merged over the component/app/defaults.
  final SwitchStyle? theme;
  State<Switch> createState();
}
```
