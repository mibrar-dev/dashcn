---
title: "Class: ChatReactionContainer"
description: "One reaction chip (emoji + count) in a pill; [onTap] toggles it, [selected] paints the selected colours."
---

```dart
/// One reaction chip (emoji + count) in a pill; [onTap] toggles it, [selected] paints the selected colours.
class ChatReactionContainer extends StatelessWidget {
  const ChatReactionContainer({super.key, required this.child, this.onTap, this.selected = false, this.theme});
  final Widget child;
  final VoidCallback? onTap;
  final bool selected;
  final ChatTheme? theme;
  Widget build(BuildContext context);
}
```
