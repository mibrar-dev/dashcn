---
title: "Mixin: StreamingClock"
description: "Frame clock shared by the streaming widgets: a vsync ticker advancing a  monotonic clock plus one-shot settle notifications."
---

```dart
/// Frame clock shared by the streaming widgets: a vsync ticker advancing a
/// monotonic clock plus one-shot settle notifications.
///
/// The ticker (not a wall-clock `Stopwatch`) drives reveal ages so pacing
/// follows fake time in widget tests and pauses offscreen. Ticks rebuild at
/// most every 16 ms. Under reduced motion (`MediaQuery.disableAnimations`)
/// the ticker never starts: callers render the settled frame instead.
///
/// States using this must also mix in [SingleTickerProviderStateMixin]
/// before it: `with SingleTickerProviderStateMixin, StreamingClock<X>`.
mixin StreamingClock<T extends StatefulWidget> on State<T>, SingleTickerProviderStateMixin<T> {
  /// Monotonic clock reading; reveal ages are `now - snapshot.changedAt`.
  /// Accumulated by hand because a restarted ticker counts from zero again.
  Duration get streamingNow;
  /// True when the ambient `MediaQuery` requests reduced motion.
  bool get streamingReducedMotion;
  void didChangeDependencies();
  void dispose();
  /// Runs the ticker while [shouldTick]; each tick advances the clock and
  /// rebuilds (throttled to ~60 Hz). Stops it otherwise.
  void syncStreamingTicker(bool shouldTick);
  /// Fires [onSettled] with [text] once [settled] for [revision]. A return
  /// to unsettled (new revision, or a swapped effect replaying the same
  /// revision) re-arms, so a replayed animation reports settling again.
  void notifyStreamingSettled({required bool settled, required int revision, required String text, required ValueChanged<String>? onSettled});
}
```
