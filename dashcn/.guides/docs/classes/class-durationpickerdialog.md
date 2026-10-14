---
title: "Class: DurationPickerDialog"
description: "The duration sheet: day/hour/minute/second digit fields clamping into  range and reporting live."
---

```dart
/// The duration sheet: day/hour/minute/second digit fields clamping into
/// range and reporting live.
class DurationPickerDialog extends StatefulWidget {
  const DurationPickerDialog({super.key, this.initialValue, this.onChanged});
  final Duration? initialValue;
  final ValueChanged<Duration?>? onChanged;
  State<DurationPickerDialog> createState();
}
```
