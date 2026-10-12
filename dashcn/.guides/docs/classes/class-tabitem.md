---
title: "Class: TabItem"
description: "An indexed tab: builds through the container's `childBuilder`."
---

```dart
/// An indexed tab: builds through the container's `childBuilder`.
class TabItem extends StatelessWidget with TabChild {
  /// Creates a tab item.
  const TabItem({super.key, required this.child});
  /// The tab content.
  final Widget child;
  bool get indexed;
  Widget build(BuildContext context);
}
```
