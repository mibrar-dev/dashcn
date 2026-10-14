---
title: "Class: WidgetStatesProvider"
description: "Provides [WidgetStatesData] to descendants through `Data`."
---

```dart
/// Provides [WidgetStatesData] to descendants through `Data`.
///
/// Combines static [states], an optional [controller] and (unless [inherit]
/// is false) the states of an ancestor provider. [WidgetStatesProvider.
/// boundary] stops inheritance entirely.
class WidgetStatesProvider extends StatelessWidget {
  /// Optional controller whose states are merged in.
  final WidgetStatesController? controller;
  /// Static states to provide.
  final Set<WidgetState>? states;
  /// The child that can read the provided states.
  final Widget child;
  /// Whether ancestor provider states are merged in.
  final bool inherit;
  /// Whether this provider blocks ancestor states.
  final bool boundary;
  /// Creates a states provider.
  const WidgetStatesProvider({super.key, this.controller, required this.child, this.states = const {}, this.inherit = true});
  /// Creates a provider that blocks ancestor states.
  const WidgetStatesProvider.boundary({super.key, required this.child});
  Widget build(BuildContext context);
}
```
