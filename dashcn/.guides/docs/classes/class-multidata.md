---
title: "Class: MultiData"
description: "A widget that provides multiple data items to its descendants."
---

```dart
/// A widget that provides multiple data items to its descendants.
class MultiData extends StatefulWidget {
  /// The data items that will be provided to the descendants.
  final List<MultiDataItem> data;
  /// The child widget.
  final Widget child;
  const MultiData({super.key, required this.data, required this.child});
  State<MultiData> createState();
}
```
