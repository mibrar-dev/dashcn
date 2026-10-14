---
title: "Class: SubFocusScope"
description: "Manages keyboard focus across its [SubFocus] children."
---

```dart
/// Manages keyboard focus across its [SubFocus] children.
///
/// The scope owns the ordered list of attached items, routes intents to the
/// focused item and moves focus to the nearest item in a direction.
class SubFocusScope extends StatefulWidget {
  /// Builds the subtree from this scope's state. When null the scope is an
  /// invisible provider.
  final SubFocusScopeBuilder? builder;
  /// Whether the first attached item is focused automatically.
  final bool autofocus;
  /// Creates a sub-focus scope.
  const SubFocusScope({super.key, this.builder, this.autofocus = false});
  State<SubFocusScope> createState();
}
```
