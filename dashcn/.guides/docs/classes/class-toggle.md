---
title: "Class: Toggle"
description: "A button that keeps an on/off state."
---

```dart
/// A button that keeps an on/off state.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` disables).
class Toggle extends StatefulWidget {
  /// Creates a toggle.
  const Toggle({super.key, this.value, this.controller, required this.child, this.size = ToggleSize.md, this.onChanged, this.enabled, this.style, this.activeStyle, this.theme, this.onHover, this.onFocusChange, this.focusNode, this.autofocus = false});
  /// Current value in controlled mode; null in controller mode.
  final bool? value;
  /// Controller mode: the controller owns the value.
  final ToggleController? controller;
  /// Toggle content, usually a `Text` or an icon.
  final Widget child;
  /// Fixed size row. Defaults to [ToggleSize.md] (h-9 = 36).
  final ToggleSize size;
  /// Called with the next value in controlled mode.
  final ValueChanged<bool>? onChanged;
  /// Overrides the enabled state; null means "interactive when controlled or
  /// controller-driven".
  final bool? enabled;
  /// Widget-leg override for the off state (old `SelectedButton.style`).
  final ToggleStyle? style;
  /// Widget-leg override for the on state (old `selectedStyle`).
  final ToggleStyle? activeStyle;
  /// Generic widget-leg override, merged under [style]/[activeStyle].
  final ToggleStyle? theme;
  /// Called when the hover state changes.
  final ValueChanged<bool>? onHover;
  /// Called when the focus state changes.
  final ValueChanged<bool>? onFocusChange;
  /// Focus node. A node is created internally when [autofocus] is true and
  /// this is null.
  final FocusNode? focusNode;
  /// Whether the toggle requests focus when first built.
  final bool autofocus;
  State<Toggle> createState();
}
```
