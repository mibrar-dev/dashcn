---
title: "Class: StreamingMarkdownSplit"
description: "Markdown streaming partition: the stable prefix renders as plain settled  markdown while the unstable tail re-renders with the reveal animation."
---

```dart
/// Markdown streaming partition: the stable prefix renders as plain settled
/// markdown while the unstable tail re-renders with the reveal animation.
///
/// Stability comes from [StreamingStableLength]: only whole lines past an
/// unclosed fence, math block, details block or table count as unstable, so
/// everything before it commits verbatim.
class StreamingMarkdownSplit {
  StreamingMarkdownSplit({required this.stableLengthOf});
  /// Stability function: leading characters that parse identically once
  /// more text arrives.
  final StreamingStableLength stableLengthOf;
  /// Last full source seen.
  String source;
  /// Committed stable prefix (settled markdown).
  String committed;
  /// Unstable tail (animated).
  String pending;
  /// Pending units already revealed (shared prefix across appends).
  List<String> stableUnits;
  /// Pending units still animating.
  List<String> animatedUnits;
  /// Clock reading of the latest pending change.
  Duration changedAt;
  /// Folds [next] in: a non-append edit resets from scratch, an append
  /// keeps the shared pending prefix stable and animates only the new tail.
  void applyIncoming(String next, {required bool forceReset, required bool animateByWord, required Duration now});
  /// Moves the stable leading run of [pending] into [committed].
  int promoteStable();
}
```
