---
title: "Mixin: SubFocusState"
description: "Focus interface of a single item inside a [SubFocusScope]."
---

```dart
/// Focus interface of a single item inside a [SubFocusScope].
mixin SubFocusState {
  /// Render box of this item, or null when unmounted.
  RenderBox? findRenderObject();
  /// Scrolls this item into view.
  void ensureVisible({ScrollPositionAlignmentPolicy alignmentPolicy = ScrollPositionAlignmentPolicy.explicit});
  /// Whether this item currently has focus.
  bool get isFocused;
  /// Whether this item can receive focus.
  bool get isEnabled;
  /// Requests focus from the parent scope.
  bool requestFocus();
  /// Invokes [intent] on this item's actions.
  Object? invokeAction(Intent intent);
  /// Number of times this item has received focus.
  int get focusCount;
  /// Called by the parent scope to update the focus state.
  void markFocused(bool focused);
  /// Removes focus from this item.
  bool unfocus();
}
```
