---
title: "Class: CardContent"
description: "Body of the card (upstream `CardContent`)."
---

```dart
/// Body of the card (upstream `CardContent`).
class CardContent extends StatelessWidget {
  /// Creates card content.
  const CardContent({super.key, required this.child, this.padding});
  /// Content.
  final Widget child;
  /// Padding override; null falls back to the card padding.
  final EdgeInsetsGeometry? padding;
  Widget build(BuildContext context);
}
```
