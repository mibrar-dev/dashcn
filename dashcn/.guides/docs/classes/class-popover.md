---
title: "Class: Popover"
description: "A handle to a presented popover."
---

```dart
/// A handle to a presented popover.
class Popover {
  /// Key of the overlay widget, used to reach its state.
  final GlobalKey<OverlayHandlerStateMixin> key;
  /// Completer that tracks this popover's lifecycle.
  final OverlayCompleter entry;
  /// Creates a popover handle. Used by `PopoverController`.
  Popover.from(this.key, this.entry);
  /// Closes this popover, optionally without animation.
  Future<void> close([bool immediate = false]);
  /// Schedules this popover to close after the current frame.
  void closeLater();
  /// Removes this popover without animation.
  void remove();
  /// Current overlay state, or null when not mounted.
  OverlayHandlerStateMixin? get currentState;
}
```
