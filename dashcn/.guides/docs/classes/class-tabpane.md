---
title: "Class: TabPane"
description: "An IDE-style tab bar over a content card: sortable tabs, scrollable with  edge fades on overflow, dividers between idle tabs."
---

```dart
/// An IDE-style tab bar over a content card: sortable tabs, scrollable with
/// edge fades on overflow, dividers between idle tabs.
///
/// Controlled: [focused] selects, [onFocused] reports taps and drop
/// landings. Null [onSort] renders a static bar. Reorder never mutates
/// [items]: the new order is a copy handed to [onSort].
class TabPane<T> extends StatefulWidget {
  /// Creates a tab pane.
  const TabPane({super.key, required this.items, required this.itemBuilder, this.focused = 0, required this.onFocused, this.onSort, this.theme, this.containerTheme, required this.child});
  final List<TabPaneData<T>> items;
  final TabPaneItemBuilder<T> itemBuilder;
  final int focused;
  final ValueChanged<int> onFocused;
  final ValueChanged<List<TabPaneData<T>>>? onSort;
  final TabPaneTheme? theme;
  /// Container layout defaults; resolved and forwarded to [TabContainer].
  final TabContainerTheme? containerTheme;
  final Widget child;
  State<TabPane<T>> createState();
}
```
