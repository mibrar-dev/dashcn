---
title: "Class: RovingItem"
description: "One registered member of a roving group."
---

```dart
/// One registered member of a roving group.
class RovingItem<T> {
  /// Creates a registration.
  const RovingItem({required this.key, required this.value, required this.enabled, required this.selected, required this.requestFocus});
  /// The member's own key, so the group can drop the entry again.
  final Object key;
  /// The value the member stands for.
  final T value;
  /// Whether the member can be reached.
  final bool enabled;
  /// Whether the member is the current one.
  final bool selected;
  /// Moves focus to the member.
  final VoidCallback requestFocus;
}
```
