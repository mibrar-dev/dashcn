---
title: "Class: TabContainer"
description: "Assigns indices to [TabItem] children and lays them out."
---

```dart
/// Assigns indices to [TabItem] children and lays them out.
///
/// Non-indexed children render as-is. [Tabs] and [TabPane] supply the upstream
/// paint through `builder`/`childBuilder`.
class TabContainer extends StatelessWidget {
  /// Creates a tab container.
  ///
  /// [builder]/[childBuilder] are explicit: app-wide defaults resolve in
  /// [Tabs]/[TabPane] through `TabContainerTheme` and are forwarded here.
  const TabContainer({super.key, required this.selected, required this.onSelect, required this.children, this.builder, this.childBuilder});
  /// Currently selected index.
  final int selected;
  /// Selection callback; null renders every tab disabled.
  final ValueChanged<int>? onSelect;
  /// Tab children in order.
  final List<TabChild> children;
  /// Layout override; null lays children in a column.
  final TabBuilder? builder;
  /// Per-tab wrapper override; null passes children through.
  final TabChildBuilder? childBuilder;
  Widget build(BuildContext context);
}
```
