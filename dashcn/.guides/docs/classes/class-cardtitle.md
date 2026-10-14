---
title: "Class: CardTitle"
description: "Card heading (upstream `CardTitle`): semibold, tight tracking."
---

```dart
/// Card heading (upstream `CardTitle`): semibold, tight tracking.
class CardTitle extends StatelessWidget {
  /// Creates a card title.
  const CardTitle({super.key, required this.child, this.style});
  /// Title content.
  final Widget child;
  /// Text style override.
  final TextStyle? style;
  Widget build(BuildContext context);
}
```
