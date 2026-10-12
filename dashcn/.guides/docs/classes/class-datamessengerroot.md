---
title: "Class: DataMessengerRoot"
description: "The root of a data messenger tree."
---

```dart
/// The root of a data messenger tree. Stores every kind of forwardable data
/// and provides it to descendants it reaches from the query context.
class DataMessengerRoot extends StatefulWidget {
  /// The child widget.
  final Widget child;
  const DataMessengerRoot({super.key, required this.child});
  State<DataMessengerRoot> createState();
}
```
