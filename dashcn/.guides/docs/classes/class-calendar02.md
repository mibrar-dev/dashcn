---
title: "Class: Calendar02"
description: "A scheduling panel: a month calendar and the selected day's agenda."
---

```dart
/// A scheduling panel: a month calendar and the selected day's agenda.
class Calendar02 extends StatefulWidget {
  /// Creates the block.
  const Calendar02({super.key, this.onBook});
  /// Called with the picked slot label when "Book a meeting" is tapped.
  final ValueChanged<String>? onBook;
  State<Calendar02> createState();
}
```
