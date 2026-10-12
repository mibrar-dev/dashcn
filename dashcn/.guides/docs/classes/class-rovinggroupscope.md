---
title: "Class: RovingGroupScope"
description: "Provides one [RovingGroupRegistry] to the members of a group."
---

```dart
/// Provides one [RovingGroupRegistry] to the members of a group.
class RovingGroupScope<T> extends StatelessWidget {
  /// Creates the scope.
  const RovingGroupScope({super.key, required this.registry, required this.child});
  /// Wraps the members in the scope.
  final Widget child;
  /// The registry the members write to.
  final RovingGroupRegistry<T> registry;
  Widget build(BuildContext context);
}
```
