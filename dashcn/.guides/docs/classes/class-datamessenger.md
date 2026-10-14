---
title: "Class: DataMessenger"
description: "A messenger that stores forwardable data of type [T] and provides it to  descendants."
---

```dart
/// A messenger that stores forwardable data of type [T] and provides it to
/// descendants. Only data of the same type registers here.
class DataMessenger<T> extends StatefulWidget {
  /// The child widget.
  final Widget child;
  const DataMessenger({super.key, required this.child});
  State<DataMessenger<T>> createState();
}
```
