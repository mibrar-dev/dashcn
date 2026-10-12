---
title: "Class: ChatReaction"
description: "Reaction chips hung over a bubble's side corner (corner maps to [OverlapCorner] by enum order); each chip toggles through its own `ChatReactionContainer."
---

```dart
/// Reaction chips hung over a bubble's side corner (corner maps to [OverlapCorner] by enum order); each chip toggles through its own `ChatReactionContainer.onTap`.
class ChatReaction extends StatelessWidget {
  const ChatReaction({super.key, required this.child, required this.chips, this.corner, this.gap, this.extraWidth, this.theme});
  final Widget child;
  final List<Widget> chips;
  final ChatBubbleCornerDirectional? corner;
  final double? gap;
  final double? extraWidth;
  final ChatTheme? theme;
  Widget build(BuildContext context);
}
```
