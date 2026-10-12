---
title: "Class: GooeyToastRecord"
description: "One live toast: its overlay entry, payload notifier and countdown state."
---

```dart
/// One live toast: its overlay entry, payload notifier and countdown state.
class GooeyToastRecord {
  /// Creates a record.
  GooeyToastRecord({required this.id, required this.entry, required this.data, required this.updatedAt});
  /// Stable toast id.
  final String id;
  /// Inserted overlay entry.
  final OverlayEntry entry;
  /// Mutable payload driving overlay rebuilds.
  final ValueNotifier<GooeyToastPayload> data;
  /// Last mutation timestamp, used for region ordering (newest first).
  DateTime updatedAt;
  /// Countdown timer while the toast is not interacting.
  Timer? dismissTimer;
  /// Remaining lifetime while paused by hover/press.
  Duration? remaining;
  /// When the running countdown started.
  DateTime? dismissStartedAt;
  /// Whether pointer interaction is active.
  bool interacting;
  /// Monotonic token invalidating stale transition callbacks.
  int transitionToken;
  /// Timers driving staged transitions.
  final List<Timer> transitionTimers;
  /// Cancels the staged transition timers.
  void cancelTransitionTimers();
  /// Releases the entry and every timer.
  void dispose();
}
```
