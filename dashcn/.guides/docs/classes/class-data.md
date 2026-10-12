---
title: "Class: Data"
description: "A widget that provides [T] data to its descendants."
---

```dart
/// A widget that provides [T] data to its descendants.
///
/// Use [Data.inherit] to provide a value; use [Data.boundary] to stop a value
/// of type [T] from reaching the subtree below.
class Data<T> extends StatelessWidget implements MultiDataItem {
  /// The child widget.
  final Widget? child;
  /// Provides [_data] to the subtree below [child].
  const Data.inherit({super.key, required T this._data, this.child});
  /// Stops [T] data from the ancestors from reaching the descendants.
  const Data.boundary({super.key, this.child});
  /// The provided data.
  T get data;
  Widget wrapWidget(Widget child);
  Widget build(BuildContext context);
  /// Finds and listens to data of type [T] from [context]. Throws if absent.
  static T of<T>(BuildContext context);
  /// Finds and listens to data of type [T] from [context].
  static T? maybeOf<T>(BuildContext context);
  /// Finds data of type [T] from [context] without listening for changes.
  static T find<T>(BuildContext context);
  /// Finds data of type [T] from [context] without listening for changes.
  static T? maybeFind<T>(BuildContext context);
  /// Finds forwarded data of type [T] registered by a forwardable-data
  /// ancestor through a data messenger.
  static T? maybeFindMessenger<T>(BuildContext context);
  /// Finds the outermost data of type [T] above [context].
  static T? maybeFindRoot<T>(BuildContext context);
  /// Captures every distinct data type above [from] up to (excluding) [to] so
  /// that it can be re-injected into another subtree with [CapturedData.wrap].
  static CapturedData capture({required BuildContext from, required BuildContext? to});
  Type get dataType;
}
```
