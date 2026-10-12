---
title: "Class: MultipleChoice"
description: "A single-selection scope."
---

```dart
/// A single-selection scope.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` disables).
///
/// Child items select through `Choice.choose(context, item)`.
class MultipleChoice<T> extends StatefulWidget {
  /// Creates a single-selection scope.
  const MultipleChoice({super.key, required this.child, this.value, this.controller, this.onChanged, this.enabled, this.allowUnselect, this.theme});
  /// The widget tree containing the choice items.
  final Widget child;
  /// Current selection in controlled mode.
  final T? value;
  /// Controller mode: the controller owns the selection.
  final MultipleChoiceController<T>? controller;
  /// Called with the next selection in controlled mode.
  final ValueChanged<T?>? onChanged;
  /// Overrides the enabled state; null means "interactive when controlled or
  /// controller-driven".
  final bool? enabled;
  /// Whether picking the current item again clears the selection; null falls
  /// back to the resolved theme (default `false`).
  final bool? allowUnselect;
  /// Widget-leg theme override, merged over the component/app/defaults.
  final MultipleChoiceTheme? theme;
  /// Creates the state object for this widget.
  State<MultipleChoice<T>> createState();
}
```
