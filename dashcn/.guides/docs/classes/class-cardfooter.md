---
title: "Class: CardFooter"
description: "Card footer (upstream `CardFooter`), aligned to the end by default."
---

```dart
/// Card footer (upstream `CardFooter`), aligned to the end by default.
class CardFooter extends StatelessWidget {
  /// Creates a card footer.
  const CardFooter({super.key, required this.child, this.padding, this.alignment = MainAxisAlignment.end});
  /// Footer content, usually a row of buttons.
  final Widget child;
  /// Padding override; null falls back to the card padding.
  final EdgeInsetsGeometry? padding;
  /// Main-axis alignment of the footer row.
  final MainAxisAlignment alignment;
  Widget build(BuildContext context);
}
```
