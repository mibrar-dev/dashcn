---
title: "Class: ToastEntry"
description: "Bookkeeping for one live toast."
---

```dart
/// Bookkeeping for one live toast.
///
/// The queue owns the timer, the remaining pause budget and the ordering stamp;
/// everything else about rendering belongs to the component.
class ToastEntry<T> {
  /// Creates an entry.
  ToastEntry({required this.id, required this.slot, required this.data, required this.duration, this.autoDismiss = true, this.onDismissed, DateTime? shownAt});
  /// Stable identity of this toast.
  final String id;
  /// The slot the toast occupies.
  ToastSlot slot;
  /// The component-owned payload (title, state, widget, ...).
  T data;
  /// How long the toast stays up before auto-dismiss.
  Duration duration;
  /// Whether the queue dismisses the toast on a timer.
  bool autoDismiss;
  /// Called once when the toast leaves the queue, for any reason.
  final void Function(String id)? onDismissed;
  /// When the toast entered the queue; the LIFO sort key.
  DateTime shownAt;
  /// Whether the toast is playing its exit animation before removal.
  ///
  /// Set by [ToastQueue.dismiss]; the component animates the toast out and
  /// then calls [ToastQueue.remove], so the queue stays the single source of
  /// truth for what is on screen.
  bool get isExiting;
  /// Starts the exit phase: stops the countdown and freezes interaction.
  void beginExit();
  /// Whether the auto-dismiss countdown is currently paused.
  bool get isPaused;
  /// The time left before auto-dismiss, or null when not counting down.
  Duration? get remaining;
  /// Whether this toast has a countdown that can be paused.
  bool get hasCountdown;
  /// Updates the payload and refreshes the countdown.
  ///
  /// Passing a new [duration] restarts the countdown from zero, which is what an
  /// in-place content update should do: the old `ToastController` bumped
  /// `refreshSignal` and left the original timer running, so an updated toast
  /// could vanish before the new content had been on screen at all.
  void update({T? data, Duration? duration, bool? autoDismiss});
  /// Pauses or resumes the auto-dismiss countdown, keeping the remaining time.
  void setInteracting(bool value);
  /// Cancels the countdown without removing the toast.
  void pause();
  /// Resumes a paused countdown.
  void resume();
  /// Stops the countdown; the queue still owns removal.
  void cancelTimer();
  /// Arms the countdown of a freshly shown toast.
  void start();
  /// Called by the countdown timer; the queue wires this to its own removal.
  VoidCallback onExpired;
  String toString();
}
```
