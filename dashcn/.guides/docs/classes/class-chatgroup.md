---
title: "Class: ChatGroup"
description: "A stack of [ChatBubble]s with optional avatars; it publishes its surface overrides as the scoped theme leg."
---

```dart
/// A stack of [ChatBubble]s with optional avatars; it publishes its surface overrides as the scoped theme leg.
class ChatGroup extends StatelessWidget {
  const ChatGroup({super.key, required this.children, this.alignment, this.color, this.foreground, this.variant, this.borderRadius, this.padding, this.borderColor, this.spacing, this.avatarPrefix, this.avatarSuffix, this.avatarAlignment, this.avatarSpacing, this.theme});
  /// Bubbles, top to bottom.
  final List<Widget> children;
  /// Surface overrides applied to every bubble in the group.
  final AlignmentGeometry? alignment;
  final ThemedColor? color;
  final ThemedColor? foreground;
  final ChatBubbleVariant? variant;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final ThemedColor? borderColor;
  /// Vertical gap between bubbles; null uses the theme, then `2`.
  final double? spacing;
  /// Widget shown before (or after) the bubbles, e.g. an avatar.
  final Widget? avatarPrefix;
  final Widget? avatarSuffix;
  /// Edge alignment of the avatars / gap to them; null uses the theme.
  final AlignmentGeometry? avatarAlignment;
  final double? avatarSpacing;
  /// Widget-leg theme override for the group layout and its bubbles.
  final ChatTheme? theme;
  Widget build(BuildContext context);
}
```
