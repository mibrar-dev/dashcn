---
title: "Class: ChatBubble"
description: "A chat message bubble, aligned to its side of the row."
---

```dart
/// A chat message bubble, aligned to its side of the row.
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.child, this.variant, this.alignment, this.color, this.padding, this.borderRadius, this.borderColor, this.corner, this.widthFactor, this.theme});
  final Widget child;
  final ChatBubbleVariant? variant;
  final AlignmentGeometry? alignment;
  final ThemedColor? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final ThemedColor? borderColor;
  /// Corner that sharpens / carries the tail; null = the bubble's side corner.
  final ChatBubbleCornerDirectional? corner;
  final double? widthFactor;
  /// Widget-leg theme override, merged on top of the other legs.
  final ChatTheme? theme;
  Widget build(BuildContext context);
}
```
