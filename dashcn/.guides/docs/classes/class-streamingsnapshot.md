---
title: "Class: StreamingSnapshot"
description: "One revision of a text stream: the stable prefix (rendered as-is) plus  the animated tail (revealed by the typewriter), stamped with its arrival  time."
---

```dart
/// One revision of a text stream: the stable prefix (rendered as-is) plus
/// the animated tail (revealed by the typewriter), stamped with its arrival
/// time.
class StreamingSnapshot {
  const StreamingSnapshot({required this.fullText, required this.stableChars, required this.animatedChars, required this.changedAt, required this.revision});
  /// First revision: nothing is stable, everything animates.
  factory StreamingSnapshot.initial(String text);
  /// Full latest text.
  final String fullText;
  /// Units shared with the previous revision (rendered settled).
  final List<String> stableChars;
  /// New tail units (revealed over time).
  final List<String> animatedChars;
  /// Clock reading when this revision arrived.
  final Duration changedAt;
  /// Bumped on every update; settled callbacks fire once per revision.
  final int revision;
  /// Next revision: the common rune prefix with the previous text stays
  /// stable, the rest animates. A non-append edit restarts from scratch
  /// because the prefix is empty.
  StreamingSnapshot update({required String nextText, required Duration now});
}
```
