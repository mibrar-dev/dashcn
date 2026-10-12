---
title: "Class: ToastExitTransition"
description: "Plays the exit animation of [entry] and removes it from [queue] when done."
---

```dart
/// Plays the exit animation of [entry] and removes it from [queue] when done.
///
/// While [entry] is not exiting this is a pass-through. When it becomes
/// exiting (see [ToastQueue.dismiss]) the child fades and slides towards
/// [direction]; with [collapse] it also shrinks its vertical extent so the
/// siblings animate into the freed space. On completion the entry is removed
/// through [ToastQueue.remove].
///
/// [MediaQuery.disableAnimations] skips the animation and removes the entry
/// after the current frame.
class ToastExitTransition<T> extends StatefulWidget {
  /// Creates an exit transition around [child].
  const ToastExitTransition({super.key, required this.queue, required this.entry, required this.direction, required this.child, this.collapse = false, this.duration = kToastExitDuration});
  /// Queue that owns [entry].
  final ToastQueue<T> queue;
  /// Entry whose exit phase drives the animation.
  final ToastEntry<T> entry;
  /// Direction the toast leaves towards.
  final ToastSwipeDirection direction;
  /// Toast content.
  final Widget child;
  /// Whether the child also collapses its vertical extent while leaving.
  final bool collapse;
  /// Exit animation duration.
  final Duration duration;
  State<ToastExitTransition<T>> createState();
}
```
