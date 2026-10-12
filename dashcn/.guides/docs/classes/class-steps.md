---
title: "Class: Steps"
description: "A vertical step list with numbered indicators and connectors."
---

```dart
/// A vertical step list with numbered indicators and connectors.
///
/// Each child is one step; the number is derived from its position.
///
/// ```dart
/// Steps(
///   children: <Widget>[
///     StepItem(title: const Text('Account'), content: const [Text('Email')]),
///     StepItem(title: const Text('Profile'), content: const [Text('Name')]),
///   ],
/// );
/// ```
class Steps extends StatelessWidget {
  /// Creates a steps list.
  const Steps({super.key, required this.children, this.theme});
  /// One widget per step, top to bottom.
  final List<Widget> children;
  /// Widget-leg theme override, merged on top of the other legs.
  final StepsTheme? theme;
  Widget build(BuildContext context);
}
```
