---
title: "Class: ErrorSlot"
description: "Reference for ErrorSlot"
---

```dart
class ErrorSlot extends StatelessWidget {
  /// Creates an error slot.
  const ErrorSlot({super.key, required this.scope, this.builder, this.empty = const SizedBox.shrink()});
  /// The channel to watch.
  final ErrorScope scope;
  /// Replaces the default [ErrorState].
  final Widget Function(BuildContext context, AppError error)? builder;
  /// Rendered when there is no error.
  final Widget empty;
  Widget build(BuildContext context);
}
```
