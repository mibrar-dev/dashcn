---
title: "Class: MultipleAnswer"
description: "A multi-selection scope."
---

```dart
/// A multi-selection scope.
///
/// Two modes:
/// * uncontrolled — pass a [controller]; `value`/`onChanged` must be null;
/// * controlled — pass `value` and `onChanged` (null `onChanged` disables).
///
/// Child items select through `Choice.choose(context, item)`.
class MultipleAnswer<T> extends StatefulWidget {
  /// Creates a multi-selection scope.
  const MultipleAnswer({super.key, required this.child, this.value, this.controller, this.onChanged, this.enabled, this.allowUnselect, this.theme});
  /// The widget tree containing the choice items.
  final Widget child;
  /// Current selection in controlled mode.
  final Iterable<T>? value;
  /// Controller mode: the controller owns the selection.
  final MultipleAnswerController<T>? controller;
  /// Called with the next selection in controlled mode.
  final ValueChanged<Iterable<T>?>? onChanged;
  /// Overrides the enabled state; null means "interactive when controlled or
  /// controller-driven".
  final bool? enabled;
  /// Whether picking a selected item again removes it; null falls back to the
  /// resolved theme (default `true`).
  final bool? allowUnselect;
  /// Widget-leg theme override, merged over the component/app/defaults.
  final MultipleChoiceTheme? theme;
  /// Creates the state object for this widget.
  State<MultipleAnswer<T>> createState();
}
```
