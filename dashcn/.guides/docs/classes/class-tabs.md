---
title: "Class: Tabs"
description: "A upstream pill tab strip on a muted container."
---

```dart
/// A upstream pill tab strip on a muted container.
///
/// Controlled: [index] selects, [onChanged] reports taps and arrow keys;
/// null [onChanged] disables the strip. Arrow keys walk enabled tabs and
/// activate on landing.
class Tabs extends StatefulWidget {
  /// Creates a tab strip.
  const Tabs({super.key, required this.index, required this.children, this.onChanged, this.expand = false, this.theme, this.containerTheme});
  final int index;
  final List<TabItem> children;
  final ValueChanged<int>? onChanged;
  final bool expand;
  final TabsTheme? theme;
  /// Container layout defaults; resolved and forwarded to [TabContainer].
  final TabContainerTheme? containerTheme;
  State<Tabs> createState();
}
```
