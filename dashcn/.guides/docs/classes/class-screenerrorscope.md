---
title: "Class: ScreenErrorScope"
description: "Owns a screen-level error channel and disposes it on unmount."
---

```dart
/// Owns a screen-level error channel and disposes it on unmount.
///
/// A widget, but non-visual (it only provides the scope), so it lives with the
/// rest of the scope machinery.
class ScreenErrorScope extends StatefulWidget {
  /// Creates a screen error scope.
  const ScreenErrorScope({super.key, required this.child, this.scopeKey, this.clearOnInit = false});
  /// Subtree that can read the scope.
  final Widget child;
  /// Explicit channel key; a unique key is generated when null.
  final String? scopeKey;
  /// Whether the channel is cleared when the scope mounts.
  final bool clearOnInit;
  /// The nearest [ScreenErrorScopeState].
  static ScreenErrorScopeState of(BuildContext context);
  State<ScreenErrorScope> createState();
}
```
