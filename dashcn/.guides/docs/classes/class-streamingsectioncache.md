---
title: "Class: StreamingSectionCache"
description: "Memoized content section: rebuilds only when its data changes, so a  settled section never rebuilds on animation frames."
---

```dart
/// Memoized content section: rebuilds only when its data changes, so a
/// settled section never rebuilds on animation frames.
class StreamingSectionCache {
  Widget? widget;
  String data;
  /// Returns the cached widget, rebuilding through [build] on new [data].
  Widget render(String data, Widget Function(String data) build);
  /// Drops the cached widget (call when non-data config changes).
  void invalidate();
}
```
