---
title: "Class: SubFocus"
description: "An individual focusable item within a [SubFocusScope]."
---

```dart
/// An individual focusable item within a [SubFocusScope].
///
/// Attaches itself to the nearest scope, tracks focus state and exposes it
/// to [builder].
class SubFocus extends StatefulWidget {
  /// Builds the child from the current focus state.
  final SubFocusBuilder builder;
  /// Whether this item can receive focus. Defaults to true.
  final bool enabled;
  /// Creates a focusable item.
  const SubFocus({super.key, required this.builder, this.enabled = true});
  State<SubFocus> createState();
}
```
