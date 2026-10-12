---
title: "Class: ControlledComponentAdapter"
description: "Wires the [ControlledComponent] contract to a hand-written [builder]."
---

```dart
/// Wires the [ControlledComponent] contract to a hand-written [builder].
///
/// Handles both modes: with a [controller] the controller is the source of
/// truth and pushes changes into the widget; without one the adapter keeps the
/// value itself. [onChanged] fires either way.
///
/// ```dart
/// ControlledComponentAdapter<bool>(
///   initialValue: false,
///   builder: (context, data) => GestureDetector(
///     onTap: data.enabled ? () => data.onChanged(!data.value) : null,
///     child: Text('${data.value}'),
///   ),
/// );
/// ```
class ControlledComponentAdapter<T> extends StatefulWidget with ControlledComponent<T> {
  /// Creates an adapter over [builder].
  ///
  /// Either [controller] or [initialValue] must be supplied.
  const ControlledComponentAdapter({super.key, required this.builder, this.initialValue, this.onChanged, this.controller, this.enabled = true});
  final T? initialValue;
  final ValueChanged<T>? onChanged;
  final bool enabled;
  final ComponentController<T>? controller;
  /// Builds the UI from the current state.
  final Widget Function(BuildContext context, ControlledComponentData<T> data) builder;
  State<ControlledComponentAdapter<T>> createState();
}
```
