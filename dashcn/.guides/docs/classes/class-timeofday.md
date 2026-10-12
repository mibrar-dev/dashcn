---
title: "Class: TimeOfDay"
description: "A time-of-day value used by time pickers and form keys."
---

```dart
/// A time-of-day value used by time pickers and form keys.
///
/// Mirrors the constructor surface of Material's `TimeOfDay` so form code can
/// drop its Material import without changing call sites.
class TimeOfDay {
  /// Hour component (0-23).
  final int hour;
  /// Minute component (0-59).
  final int minute;
  /// Second component (0-59).
  final int second;
  /// Creates a [TimeOfDay] with the given components.
  const TimeOfDay({required this.hour, required this.minute, this.second = 0});
  /// Creates a PM time (adds 12 to the hour).
  const TimeOfDay.pm({required int hour, required this.minute, this.second = 0});
  /// Creates an AM time.
  const TimeOfDay.am({required this.hour, required this.minute, this.second = 0});
  /// Creates a [TimeOfDay] from a [DateTime].
  TimeOfDay.fromDateTime(DateTime dateTime);
  /// Creates a [TimeOfDay] from a [Duration].
  TimeOfDay.fromDuration(Duration duration);
  /// Creates a [TimeOfDay] for the current wall-clock time.
  TimeOfDay.now();
  /// Returns a copy with the given fields replaced.
  TimeOfDay copyWith({ValueGetter<int>? hour, ValueGetter<int>? minute, ValueGetter<int>? second});
  /// Returns a copy with the given fields replaced.
  TimeOfDay replacing({int? hour, int? minute, int? second});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
