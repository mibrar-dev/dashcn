---
title: "Class: CachedValueWidget"
description: "A widget that caches its builder result until [CachedValueWidget."
---

```dart
/// A widget that caches its builder result until [CachedValueWidget.value]
/// reports a rebuild (or simply changes, when it is not a [CachedValue]).
class CachedValueWidget<T> extends StatefulWidget {
  /// The value to cache and pass to the builder.
  final T value;
  /// Builds the widget for the current value.
  final Widget Function(BuildContext context, T value) builder;
  const CachedValueWidget({super.key, required this.value, required this.builder});
  State<CachedValueWidget<T>> createState();
}
```
