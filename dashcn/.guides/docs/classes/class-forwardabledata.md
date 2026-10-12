---
title: "Class: ForwardableData"
description: "A widget that provides [data] to the nearest ancestor messenger so it can  be found from other subtrees with [Data."
---

```dart
/// A widget that provides [data] to the nearest ancestor messenger so it can
/// be found from other subtrees with [Data.maybeFindMessenger].
class ForwardableData<T> extends StatefulWidget {
  /// The data that will be forwarded.
  final T data;
  /// The child widget.
  final Widget child;
  const ForwardableData({super.key, required this.data, required this.child});
  State<ForwardableData<T>> createState();
}
```
