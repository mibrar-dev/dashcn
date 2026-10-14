---
title: "Class: TabContainerData"
description: "Indexing context a [TabContainer] publishes to its tab children."
---

```dart
/// Indexing context a [TabContainer] publishes to its tab children.
class TabContainerData {
  /// Creates container data.
  const TabContainerData({required this.index, required this.selected, required this.onSelect, required this.childBuilder});
  /// This tab's index.
  final int index;
  /// The currently selected index.
  final int selected;
  /// Selection callback; null renders tabs disabled.
  final ValueChanged<int>? onSelect;
  /// Wrapper applied to each tab child.
  final TabChildBuilder childBuilder;
  /// Nearest ancestor data; asserts inside a tab container.
  static TabContainerData of(BuildContext context);
  /// Nearest ancestor data, or null.
  static TabContainerData? maybeOf(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
