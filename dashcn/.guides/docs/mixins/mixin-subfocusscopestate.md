---
title: "Mixin: SubFocusScopeState"
description: "Scope interface managing the focus order of its [SubFocus] children."
---

```dart
/// Scope interface managing the focus order of its [SubFocus] children.
mixin SubFocusScopeState {
  /// Invokes [intent] on the currently focused child.
  Object? invokeActionOnFocused(Intent intent);
  /// Moves focus to the nearest child in [direction].
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]);
  /// Nearest ancestor scope, or null.
  static SubFocusScopeState? maybeOf(BuildContext context);
  /// Detaches [child] from this scope.
  void detach(SubFocusState child);
  /// Attaches [child] to this scope.
  bool attach(SubFocusState child);
  /// Transfers focus to [child].
  bool requestFocus(SubFocusState child);
  /// Removes focus from [child].
  bool unfocus(SubFocusState child);
}
```
