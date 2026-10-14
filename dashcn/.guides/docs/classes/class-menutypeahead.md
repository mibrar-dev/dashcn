---
title: "Class: MenuTypeahead"
description: "Accumulates keystrokes into a search prefix and expires it after a pause,  the type-to-select behaviour of desktop menus."
---

```dart
/// Accumulates keystrokes into a search prefix and expires it after a pause,
/// the type-to-select behaviour of desktop menus.
class MenuTypeahead {
  /// Creates a buffer; [resetDelay] is how long the prefix stays valid
  /// without a new character.
  MenuTypeahead({this.resetDelay = const Duration(milliseconds: 600)});
  /// Maximum gap between two characters before the prefix restarts.
  final Duration resetDelay;
  /// The current search prefix, possibly empty.
  String get query;
  /// Appends [character] to the prefix unless it is not a single rune; a gap
  /// longer than [resetDelay] starts a new prefix.
  ///
  /// [now] is the caller's monotonic timestamp, read from the wall clock when
  /// omitted. Pass it explicitly to keep behaviour deterministic.
  void type(String character, {Duration? now});
  /// Clears the prefix and its timestamp.
  void reset();
  /// Index of the first label starting with [query], searching from [start]
  /// and wrapping, or null when the prefix is empty or nothing matches.
  ///
  /// Comparison is case-insensitive; entries rejected by [isEnabled] are
  /// skipped.
  int? match(List<String> labels, {int start = 0, bool Function(int index)? isEnabled});
}
```
