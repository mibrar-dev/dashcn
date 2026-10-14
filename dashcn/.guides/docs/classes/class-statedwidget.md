---
title: "Class: StatedWidget"
description: "A widget that shows one of several children depending on the ambient  [WidgetStatesData]."
---

```dart
/// A widget that shows one of several children depending on the ambient
/// [WidgetStatesData].
///
/// Three constructors: the default one takes explicit per-state widgets, the
/// `.map()` one takes a state-to-widget map and `.builder()` one derives the
/// widget from the states set.
abstract class StatedWidget extends StatelessWidget {
  /// State priority order used by the default constructor.
  static const List<WidgetState> defaultStateOrder = [WidgetState.disabled, WidgetState.error, WidgetState.selected, WidgetState.pressed, WidgetState.hovered, WidgetState.focused];
  /// Shows an explicit widget per state, in [order] priority.
  factory StatedWidget({Key? key, required Widget child, List<WidgetState> order, Widget? disabled, Widget? selected, Widget? pressed, Widget? hovered, Widget? focused, Widget? error});
  /// Shows the widget mapped to the first active state.
  factory StatedWidget.map({Key? key, required Map<Object, Widget> states, Widget? child});
  /// Builds the widget from the active states set.
  factory StatedWidget.builder({Key? key, required Widget Function(BuildContext context, Set<WidgetState> states) builder});
}
```
