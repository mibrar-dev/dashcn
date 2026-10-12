---
title: "Class: Tracker"
description: "A row of coloured activity segments."
---

```dart
/// A row of coloured activity segments.
///
/// ```dart
/// Tracker(
///   data: <TrackerData>[
///     TrackerData(tooltip: const Text('Healthy'), level: TrackerLevel.fine),
///     TrackerData(tooltip: const Text('Down'), level: TrackerLevel.critical),
///   ],
/// );
/// ```
class Tracker extends StatelessWidget {
  /// Creates a tracker.
  const Tracker({super.key, required this.data, this.theme});
  /// Segments, in visual order.
  final List<TrackerData> data;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final TrackerTheme? theme;
  Widget build(BuildContext context);
}
```
