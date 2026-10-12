---
title: "Class: CardHeader"
description: "Vertical container for the card header block (upstream `CardHeader`)."
---

```dart
/// Vertical container for the card header block (upstream `CardHeader`).
class CardHeader extends StatelessWidget {
  /// Creates a card header.
  const CardHeader({super.key, required this.child, this.padding});
  /// Header content, usually a [CardTitle] plus a [CardDescription].
  final Widget child;
  /// Padding override; null falls back to the card padding.
  final EdgeInsetsGeometry? padding;
  Widget build(BuildContext context);
}
```
