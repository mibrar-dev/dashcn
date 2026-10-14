---
title: "Class: OverlayAnchorScope"
description: "Provides a local [OverlayAnchorRegistry] to its subtree, so anchor keys need  only be unique inside it."
---

```dart
/// Provides a local [OverlayAnchorRegistry] to its subtree, so anchor keys need
/// only be unique inside it. The [OverlayAnchor] and the opening
/// [LinkedAnchor] must sit under the same scope.
class OverlayAnchorScope extends StatefulWidget {
  /// Creates a scope.
  const OverlayAnchorScope({super.key, required this.child});
  /// The subtree that shares this scope's registry.
  final Widget child;
  State<OverlayAnchorScope> createState();
}
```
