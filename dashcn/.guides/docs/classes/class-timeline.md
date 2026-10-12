---
title: "Class: Timeline"
description: "A vertical timeline of chronological entries."
---

```dart
/// A vertical timeline of chronological entries.
///
/// ```dart
/// Timeline(
///   data: [
///     TimelineData(
///       time: Text('09:00'),
///       title: Text('Kickoff'),
///       content: Text('Project kickoff meeting.'),
///     ),
///   ],
/// );
/// ```
class Timeline extends StatelessWidget {
  /// Creates a timeline from [data].
  const Timeline({super.key, required this.data, this.timeConstraints, this.theme});
  /// Entries rendered top to bottom.
  final List<TimelineData> data;
  /// Widget-leg width of the time column; null uses [TimelineTheme.timeConstraints]
  /// or the `120 * scaling` default.
  final BoxConstraints? timeConstraints;
  /// Widget-leg theme override, merged on top of the other legs.
  final TimelineTheme? theme;
  Widget build(BuildContext context);
}
```
