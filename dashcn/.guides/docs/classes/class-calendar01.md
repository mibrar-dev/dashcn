---
title: "Class: Calendar01"
description: "A date-range card: the calendar, a range summary and footer actions."
---

```dart
/// A date-range card: the calendar, a range summary and footer actions.
class Calendar01 extends StatefulWidget {
  /// Creates the block.
  const Calendar01({super.key, this.onApply, this.onClear});
  /// Called with the current range when Apply is tapped.
  final ValueChanged<CalendarValue?>? onApply;
  /// Called when Clear resets the selection.
  final VoidCallback? onClear;
  State<Calendar01> createState();
}
```
