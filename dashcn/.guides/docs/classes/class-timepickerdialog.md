---
title: "Class: TimePickerDialog"
description: "The clock sheet: hour/minute(/second) digit fields plus AM/PM in 12-hour  mode."
---

```dart
/// The clock sheet: hour/minute(/second) digit fields plus AM/PM in 12-hour
/// mode. Edits clamp into range and report live.
class TimePickerDialog extends StatefulWidget {
  const TimePickerDialog({super.key, this.initialValue, this.onChanged, required this.use24HourFormat, this.showSeconds = false});
  final TimeOfDay? initialValue;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool use24HourFormat;
  final bool showSeconds;
  State<TimePickerDialog> createState();
}
```
