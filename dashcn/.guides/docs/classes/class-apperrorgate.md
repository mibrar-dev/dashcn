---
title: "Class: AppErrorGate"
description: "Reference for AppErrorGate"
---

```dart
class AppErrorGate extends StatelessWidget {
  /// Creates an error gate.
  const AppErrorGate({super.key, required this.child, required this.notifier, this.overlayBuilder, this.blockInteraction = true});
  /// The subtree kept mounted behind the overlay.
  final Widget child;
  /// The channel to watch.
  final ValueListenable<AppError?> notifier;
  /// Replaces the default overlay.
  final Widget Function(BuildContext context, AppError error)? overlayBuilder;
  /// Whether the subtree is blocked while an error is shown.
  final bool blockInteraction;
  Widget build(BuildContext context);
}
```
