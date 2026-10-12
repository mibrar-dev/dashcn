---
title: "Class: TimelineData"
description: "One row of a [Timeline]."
---

```dart
/// One row of a [Timeline].
class TimelineData {
  /// Creates one timeline entry.
  const TimelineData({required this.time, required this.title, this.content, this.color});
  /// Time/label column, right aligned above the indicator.
  final Widget time;
  /// Main heading of the entry.
  final Widget title;
  /// Optional detail under [title].
  final Widget? content;
  /// Per-entry indicator/connector colour; null uses [TimelineTheme.color].
  final ThemedColor? color;
}
```
