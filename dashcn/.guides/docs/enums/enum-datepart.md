---
title: "Enum: DatePart"
description: "One component of a calendar date."
---

```dart
/// One component of a calendar date.
///
/// Date pickers use it to order and label their fields, and as the key type of
/// the "which components are set" map. The concepts here are language-neutral;
/// their *labels* are locale data, via
/// [ComponentLocalizationsExtensions.getDatePartAbbreviation].
enum DatePart {
  /// The year, conventionally written with four digits.
  year,
  /// The month, 1-12.
  month,
  /// The day of the month.
  day,
}
```
