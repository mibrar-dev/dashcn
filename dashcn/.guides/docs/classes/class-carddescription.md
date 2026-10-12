---
title: "Class: CardDescription"
description: "Card supporting text (upstream `CardDescription`): muted, 14px."
---

```dart
/// Card supporting text (upstream `CardDescription`): muted, 14px.
class CardDescription extends StatelessWidget {
  /// Creates a card description.
  const CardDescription({super.key, required this.child, this.style});
  /// Description content.
  final Widget child;
  /// Text style override.
  final TextStyle? style;
  Widget build(BuildContext context);
}
```
